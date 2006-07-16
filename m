Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946075AbWGPOeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946075AbWGPOeP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 10:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946080AbWGPOeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 10:34:14 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:35984 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1946075AbWGPOeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 10:34:11 -0400
Message-ID: <44BA4E5E.7060803@linuxtv.org>
Date: Sun, 16 Jul 2006 10:34:06 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc2 | UTS Release version does not match current
 version
References: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, there it is, in all the usual places.
>
> I think the bulk of it are some MIPS and UML updates, along with a e1000 
> driver update, but there's various more random things, including just lots 
> of cleanups.
>   

I get this when building using debian's make-kpkg:

The UTS Release version in include/linux/version.h
     ""
does not match current version:
     "2.6.18-rc2"
Please correct this.


I didnt test building -rc1 this way yet, so I dont know when this was 
introduced, but I don't have this problem with 2.6.17.y

-Mike
