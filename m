Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbTAVPvb>; Wed, 22 Jan 2003 10:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbTAVPvb>; Wed, 22 Jan 2003 10:51:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:1032 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261640AbTAVPva>;
	Wed, 22 Jan 2003 10:51:30 -0500
Date: Wed, 22 Jan 2003 16:59:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: test suite?
Message-ID: <20030122155955.GA1219@mars.ravnborg.org>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301220840530.2622-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301220840530.2622-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 08:44:05AM -0500, Robert P. J. Day wrote:
> 
>   i've noticed references to "test suites" for kernels, but
> is there any one-step convenient way to select every possible
> option for test-compiling a new kernel, just to see if it builds?
> perhaps an "everything" option?

Try "make help" some day..

make allyesconfig
make allmodconfig
make allnoconfig <- Opposite of what you ask for.

	Sam
