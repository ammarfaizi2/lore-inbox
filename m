Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbTCPSeo>; Sun, 16 Mar 2003 13:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262724AbTCPSeo>; Sun, 16 Mar 2003 13:34:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:36111 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262722AbTCPSen>;
	Sun, 16 Mar 2003 13:34:43 -0500
Date: Sun, 16 Mar 2003 19:45:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Maxime <x@organigramme.net>
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: PROBLEM: make bzImage fails when LANG set
Message-ID: <20030316184532.GB892@mars.ravnborg.org>
Mail-Followup-To: Maxime <x@organigramme.net>,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
References: <3E74AC1C.8010901@organigramme.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E74AC1C.8010901@organigramme.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 11:53:48AM -0500, Maxime wrote:
> 2
> 
> Notice it is in french.  I search on the web for similar problem, and 
> find a few examples, all in foreing language.  Nobody seemed to know how 
> to solve this.  I then remembered I added these lines to my /etc/profile:

Keith Owens once posted this snippet:
-nostdinc $(shell LANG=C $(CC) -print-search-dirs | sed -ne 's/install:+\(.*\)/-I \1include/gp')

Try searching for "How to do -nostdinc?".

	Sam
