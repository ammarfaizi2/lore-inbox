Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWDLJGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWDLJGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWDLJGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:06:41 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:4237 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750883AbWDLJGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:06:40 -0400
Date: Wed, 12 Apr 2006 11:06:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pramod Srinivasan <pramods@gmail.com>
cc: David Weinehall <tao@acc.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
In-Reply-To: <fcff6ec10604120001o18ca9edxf11ed055b5601e2a@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0604121057360.12544@yvahk01.tjqt.qr>
References: <fcff6ec10604120001o18ca9edxf11ed055b5601e2a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<obligatory_ianal_marker>

>Suppose I use the linux-vrf patch for the kernel that is freely
>available and use the extended setsocket options such as SO_VRF in an
>application, do I have to release my application under GPL since I am
>using a facility in the kernel that a standard linux kernel does not
>provide?
>

If vrf has no other uses besides your proprietary application, I'd shudder.

>Suppose my LKM driver adds a extra header to all outgoing packets and
>removes the extra header from the incoming packets, should this driver
>be released under GPL.? In a way it extends the functionality of
>linux, if I do release the driver code under GPL because this was
>built with linux  in mind, Should I release the application  which
>adds intelligence to interpret the extra header under GPL?
>

I don't know an answer (not even a rough one), since there is AFAICS one 
example of what you describe: the CiscoVPN kernel module. The source is 
available (so you have a chance to run it on any kernel you like), but it's 
got a typical EULA. No sign of GPL.



Jan Engelhardt
-- 
