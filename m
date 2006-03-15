Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWCOL3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWCOL3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 06:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWCOL3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 06:29:18 -0500
Received: from sccrmhc12.comcast.net ([204.127.200.82]:52426 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751749AbWCOL3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 06:29:18 -0500
Message-ID: <4417FA8C.7090106@comcast.net>
Date: Wed, 15 Mar 2006 06:29:16 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prakash Punnoor <prakash@punnoor.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: New libata PATA patch for 2.6.16-rc1
References: <1142262431.25773.25.camel@localhost.localdomain> <200603132331.33129.prakash@punnoor.de> <200603151154.15691.prakash@punnoor.de>
In-Reply-To: <200603151154.15691.prakash@punnoor.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:

>Am Montag März 13 2006 23:31 schrieb Prakash Punnoor:
>  
>
>>Hi,
>>
>>I tried your ide1 patch with 2.6.16-rc6 and NFORCE2 board, thus using the
>>AMD driver (and sil sata driver).
>>    
>>
>
>[...]
>
>  
>
>>I will see how the DVD+RW drive behaves and let you know whether it makes
>>troubles. :-)
>>    
>>
>
>Ok, I am having some troubles burning CDs/DVDs. I am using k3b as front-end 
>and it has troubles to detect the type of disc inserted. If you eg insert a 
>cd-rw the dialog changes the detected medium around (about each second): 
>cd-rom, cd-rw, etc. Same with DVD+R. It detects DVD+R, waiting a second, than 
>appendable DVD+R etc. But then it thinks it is a RW so it wants to 
>blank/format/whatever it and this breaks, ie. I can't start the burning. It 
>worked fine with a DVD+RW though. And ignoring the message and blanking in 
>menu, I could also write a cd-rw.
>
>
>I am not sure what is causing the problem. Could dbus/hal be also trouble 
>makers? I don't know whether k3b is making something stupid, as well. Last 
>time I tried I had no problem with the ide driver though. So I don't know 
>whether ATAPI support in libata still needs polishing or whether Alan's PATA 
>patch is missing something or whatever...
>
>
>What infos should I provide to make diagnosis easier?
>  
>
graveman had the same problem.   I went and used cdrecord-prodvd and 
haven't had a problem with direct command line, gcombust, or xcdroast 
(those are all plain frontends to the userspace tools).   

This seems to be a userspace problem in operating with libata/pata.    
xcdroast/gcombust and regular commandline usage of cdrecord-prodvd work 
fine.
