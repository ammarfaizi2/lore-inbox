Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbTBST7f>; Wed, 19 Feb 2003 14:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTBST7e>; Wed, 19 Feb 2003 14:59:34 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:13831 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264681AbTBST7d>;
	Wed, 19 Feb 2003 14:59:33 -0500
Date: Wed, 19 Feb 2003 21:09:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.62
Message-ID: <20030219200935.GB1623@mars.ravnborg.org>
Mail-Followup-To: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030219193907.GA17248@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219193907.GA17248@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 11:39:07AM -0800, Greg KH wrote:
> Hi,
> 
> Finally, here's the klibc addition against the latest 2.5.62 bk kernel
> tree.

A few comments that I had queued.


>  usr/lib/arch/arm/MCONFIG                        |   26
Any good reasons for such a screaming name?
makefile.config eventually.
 
>  usr/lib/arch/arm/Makefile.inc                   |   31

No extension is used for arch/arm/Makefile
Why does klibc differ in this respect?
[An answer that tell me that arch/arm/Makefile should
change is fine with me..]

>  usr/lib/makeerrlist.pl                          |   80 
>  usr/lib/socketcalls.pl                          |   75 

This mixture of code and scripts to generate code hursts my eye.
What about usr/scripts/.
I assume you do not want them in scripts/

	Sam
