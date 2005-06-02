Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVFBTRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVFBTRZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 15:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFBTRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 15:17:25 -0400
Received: from alpha.polcom.net ([217.79.151.115]:18582 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261243AbVFBTRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:17:21 -0400
Date: Thu, 2 Jun 2005 21:17:16 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 | [OFFTOPIC]: Segementation Question
In-Reply-To: <429F58CD.4020505@tiscali.de>
Message-ID: <Pine.LNX.4.63.0506022115370.14006@alpha.polcom.net>
References: <429F58CD.4020505@tiscali.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Matthias-Christian Ott wrote:

> Hi.
> I'm currently doing some research on the IA32 Segementation Concept. But 
> there's one thing I don't understand:
> If I perform a far jump it looks like this:
> jmp	16bit:32bit
>
> The 16bit are representing the segement number and the 32bit the offset. But 
> to what refers the 16bit? To the GDT or the current LDT?

IIRC, there is one bit flag in selector that decides if it is from GDT or 
LDT. But maybe I am wrong...


Grzegorz Kulewski
