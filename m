Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275424AbTHIWeC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 18:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275425AbTHIWeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 18:34:02 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:59264 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S275424AbTHIWd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 18:33:59 -0400
Date: Sun, 10 Aug 2003 00:33:58 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org,
       vojtech@suse.cz
Subject: Re: 2.6.0-test3 issue
Message-ID: <20030809223358.GA3496@finwe.eu.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	zippel@linux-m68k.org, vojtech@suse.cz
References: <20030809191326.GC8475@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809191326.GC8475@ip68-0-152-218.tc.ph.cox.net>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:

> Hello.  I just tried to compile up 2.6.0-test3 for my x86 box, and I
> noticed that the following set of options will no longer work:
> CONFIG_EMBEDDED=n
> CONFIG_SERIO=m
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> 
> The problem is that unless I set CONFIG_EMBEDDED, INPUT_KEYBOARD and
> KEYBOAD_ATKBD both get set to 'Y', regardless of the other dependancies
> (such as SERIO being 'm').

I think it's:

...
Alan Cox:
...
  o mouse and keyboard by default if not embedded
...  

change.

(I was wandering what I had done wrong, that mousedev.ko
disappeared  8)

jk

-- 
Jacek Kawa
