Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVAKPMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVAKPMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVAKPMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:12:53 -0500
Received: from host9-158.pool8252.interbusiness.it ([82.52.158.9]:2176 "EHLO
	zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S262785AbVAKPMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:12:50 -0500
Message-ID: <41E3EBB5.5030305@abinetworks.biz>
Date: Tue, 11 Jan 2005 16:07:33 +0100
From: "Ing. Gianluca Alberici" <alberici@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stamer@physnet.physik.uni-oldenburg.de, linux-kernel@vger.kernel.org
Subject: Re: Bad disks or bug ?
References: <Pine.LNX.4.61.0501111452500.23213@alexandria.physik.uni-oldenburg.de>
In-Reply-To: <Pine.LNX.4.61.0501111452500.23213@alexandria.physik.uni-oldenburg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heinrich,

Your analysis shows you know well what we're talking about and i think 
finally
you gave the optimal explanation...

I know very well the problems of the IBM DTLA series (i have a dozen of 
zombies here...)
and was mainly concerned about Maxtor disks.

Finally i agree it must be something that has to do with the use of 
hardware and/or firmware...

I will of course substitute my backup drive immediately !

Regards and thanks,

Gianluca

Heinrich Stamerjohanns wrote:

>Der Gianluca, 
>
>I guess you have an IBM Deskstar (or now Hitachi), possibly a DTLA-307045?
>
>We have the same setup: main disk is /dev/hda, backup disk (every night) 
>is /dev/hdb.
>
>One just crashed yesterday, it is the fifth IBM (out of five) that 
>crashed (this is already a replacement disk...). 
>Don't worry your IBM /dev/hda will crash sooner or later as well ;)
>
>But when I investigated after the first crash, I read something like
>that these disk especially do not cope with the situation that they are 
>only infrequently used, but then heavily (no use at all, then continous 
>backup..). The firmware has supposedly changed since then, but it
>has not helped the replacment drive.
>So I guess your problem with /dev/hdb is rather a hardware than 
>a software problem. 
>
>To be sure you could make /dev/hdb your main disk and backup to /dev/hda.
>I am quite sure that /dev/hda will give up first then. (But it happened to 
>us that the main drive died two days later, without a replaced backup 
>drive...)
>
>Greetings, Heinrich
> 
>
>--
>  Dr. Heinrich Stamerjohanns        Tel. +49-441-798-4276
>  Institute for Science Networking  stamer@uni-oldenburg.de
>  University of Oldenburg           http://isn.uni-oldenburg.de/~stamer
>
>  
>
