Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVI1LWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVI1LWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 07:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVI1LWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 07:22:51 -0400
Received: from web51005.mail.yahoo.com ([206.190.38.136]:42422 "HELO
	web51005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751225AbVI1LWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 07:22:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3n6ftFsncxwkArE9PiyOdgYDaRuj46gjzZSXbjNr+fY/RhSM5T0bBcc42fkctLsKdEJuf0jdDOhTW8em4tmp+oXQlVZqbXjYvy+fN+uNLS2+t3tKBRNwl9teBNXjvIAzFE5ce8sG6954BeMOcIb/Mymkd6um120y4eaLhL5weCU=  ;
Message-ID: <20050928112249.1040.qmail@web51005.mail.yahoo.com>
Date: Wed, 28 Sep 2005 04:22:49 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
To: Emmanuel Fleury <fleury@cs.aau.dk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <433A617F.3020507@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) What should be detected, what should not ?

I think its good to detect everything, that let a
Kernel work after the installation. I mean it the
autoconfiguration should't be only for Kernel-Hackers.
Maybe its good idea to make two type of detection

1. which detects only the HW(For Kernel-Hackers)
2. which detects all the HW and configure everything
that let the Kernel work.(for beginners)
 
> But, as Boddo Eggert pointed out (if I
> understood well), all the
> hardware which is lying outside of the box (printer,
> scanner, usb key,
> ...) could be detected if plugged when the
> autoconfig is ran. 
> Should we trust these informations (as theses
> devices can be removed at
> any time) ? Shouldn't we let the user make these
> choices by himself ?
I think it should be included, since it is up to the
user has to plug the HW in to those Ports so the
autoconfig can be detected. 

> What is the limit of the devices we can assume to be
> part of the machine
> when building this autoconfig ?

All the needed HW that the user wants or need must at
least be detected and configured.

> 2) What is the surest and the most stable way to
> detect the hardware ?
> 
> lspci, lsusb, dmidecode (or /proc and /sys) have
> been mentioned. This
> brings two sub-questions:
> - What kind of software environment / kernel release
> can we assume ?

The best was is to use HW-Detection-Tools that are in
naked Kernel. But I dont know if is lspci is in the
Kernel. I mean dmidecode is good for detecting all the
HW but it has to be installed first. And its no good
to let the user install first of all some tools so the
autoconfigure can work.
How do we get the HW detected from a naked Kernel
without any Distrubotion or whatever.   

> - How to minimize the dependencies of the detection
> from other tools ?
>  (changing all the Kconfigs just because the syntax
> of the output of one
> of these command has changed would be quite
> painful).

If something like that hapend we can put a filter in
the script, that changes the Parameter in to a new
one. 



> 3) Can this hardware detection be included in other
> interfaces ?
> 
> It would be nice to have this detection to be ran
> when no pre existing
> .config is detected in all other interfaces
> (menuconfig, config, ...).

I dont understand your question. What you mean with
interfaces??
 

Regards

Ahmad Reza Cheraghi


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
