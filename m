Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVI1Lph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVI1Lph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 07:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVI1Lph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 07:45:37 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:54158 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1750883AbVI1Lph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 07:45:37 -0400
Message-ID: <433A81F0.2080409@cs.aau.dk>
Date: Wed, 28 Sep 2005 13:43:44 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
References: <20050928112249.1040.qmail@web51005.mail.yahoo.com>
In-Reply-To: <20050928112249.1040.qmail@web51005.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmad Reza Cheraghi wrote:
> 
> I think its good to detect everything, that let a
> Kernel work after the installation. I mean it the
> autoconfiguration should't be only for Kernel-Hackers.
> Maybe its good idea to make two type of detection
> 
> 1. which detects only the HW(For Kernel-Hackers)
> 2. which detects all the HW and configure everything
> that let the Kernel work.(for beginners)

Why would a beginner compile a kernel ?

I would even say this would be bad if you can avoid them to go through
all the documentations of each option. :)

> The best was is to use HW-Detection-Tools that are in
> naked Kernel. But I dont know if is lspci is in the
> Kernel. I mean dmidecode is good for detecting all the
> HW but it has to be installed first. And its no good
> to let the user install first of all some tools so the
> autoconfigure can work.
> How do we get the HW detected from a naked Kernel
> without any Distrubotion or whatever.   

I doubt we can, at least not in the current status.

And requiring more external tools as lspci, dmidecode, etc, is probably
not right.

More I am thinking of it, more it seems that the hardware detection
softwares (lspci, dmidecode, lsusb) should be stripped down and probably
included somewhere in the kernel tree... But wouldn't be too much to pay
for having an autoconfig ? (I mean maintenance, update, debug, ... will
be way out of the scope of the kernel).

Did anybody had some though about this previously (I tried to look in
the archive of the LKM but didn't find anything relevant) ?

> I dont understand your question. What you mean with
> interfaces??

ncurses, Qt, Gtk, ... (aka menuconfig, xconfig, gconfig).

Regards
-- 
Emmanuel Fleury

My behaviour is addictive functioning in a disease process of
toxic co-dependency. I need holistic healing and wellness
before I'll accept any responsibility for my actions.
  -- Calvin & Hobbes (Bill Waterson)
