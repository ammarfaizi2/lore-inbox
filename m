Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTFKRus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTFKRus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:50:48 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:51073 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP id S263394AbTFKRuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:50:44 -0400
Date: Wed, 11 Jun 2003 19:04:35 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein31.homenet
To: Artemio <artemio@artemio.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP question
In-Reply-To: <200306112043.11923.artemio@artemio.net>
Message-ID: <Pine.LNX.4.44.0306111857210.2560-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Artemio,

SMP kernel doesn't run "faster" than a UP one, as such, but enabling SMP
support will allow you to make use of your 3 extra CPUs, e.g. by multiple
user applications at the same time, or by various tasks performed inside
the kernel. So, if you have more than one CPU definitely enable SMP
support, unless this causes your system to hang (in which case it's a bug
and you are expected to send a bugfix to this list)

Regards
Tigran

On Wed, 11 Jun 2003, Artemio wrote:

> Hello!
> 
> I have the following question.
> 
> My system is 2x 2.4Ghz Xeons.
> 
> Linux kernel 2.4.18 compiled with SMP support sees it as four processors. 
> SMP-disabled kernel sees one, of course.
> 
> I would like to know, how will it influence the system performance, if I run a 
> UP kernel?
> 
> What does the kernel SMP support add? Just some API for additinal 
> multiprocessor control? Will the SMP-enabled kernel run faster than the UP 
> one?
> 
> That's what I would like to know.
> 
> 
> 
> Thanks!
> 
> 
> Artemio.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

