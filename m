Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbTAWQoy>; Thu, 23 Jan 2003 11:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTAWQoy>; Thu, 23 Jan 2003 11:44:54 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30992 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265378AbTAWQox>;
	Thu, 23 Jan 2003 11:44:53 -0500
Date: Thu, 23 Jan 2003 17:52:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030123165256.GA1092@mars.ravnborg.org>
Mail-Followup-To: Thomas Schlichter <schlicht@uni-mannheim.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <200301231459.22789.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301231459.22789.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 02:59:22PM +0100, Thomas Schlichter wrote:
> Hi,
> 
> I have writen a small kernel module and it works perfectly, but currently (I 
> think it just begun with 2.5.59) I get the warning above when the module is 
> inserted. Now I am just interested what I have to change so this message 
> won't appear anymore...
> 
> Thank you much!
> 
>    Thomas Schlichter
> 
> P.S.: If my Makefile or source will help I'll give it to you...
What command did you use to build your module?
If you did no use:
make -C path/to/kernel/src SUBDIRS=$PWD modules

chances are big you did not compile the module correct.
This requires the Makefile to look like any other kernel (kbuild) makefile.

	Sam
