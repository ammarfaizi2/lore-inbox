Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264286AbRFMXUT>; Wed, 13 Jun 2001 19:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264284AbRFMXUJ>; Wed, 13 Jun 2001 19:20:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14599 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264274AbRFMXTs>; Wed, 13 Jun 2001 19:19:48 -0400
Subject: Re: Getting A Patch Into The Kernel
To: craigl@promise.com
Date: Thu, 14 Jun 2001 00:18:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <005101c0f38f$e2000960$bd01a8c0@promise.com> from "Craig Lyons" at Jun 12, 2001 03:34:43 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15AJuI-0003lm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ASIC on them as our FastTrak RAID controllers do. The 2.4 kernel will
> recognize our Ultra family of controllers, but there is a problem in that a
> FastTrak will not be recognized as a FastTrak, but as an Ultra.
> Consequently, the array on the FastTrak is not recognized as an array, but
> instead each disk is seen individually, and the users data cannot be

This is not true in 2.4.5-ac. Arjan van de Ven resolved this one.

> properly accessed. We have a patch that fixes this and are wondering if it
> is possible to get this patch into the kernel, and if so, how this would be
> done?

Im sure Arjan would love to have an official patch rather than deducing your
disk format by hand
