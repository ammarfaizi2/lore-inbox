Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133023AbRDKWt7>; Wed, 11 Apr 2001 18:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbRDKWtu>; Wed, 11 Apr 2001 18:49:50 -0400
Received: from zeus.kernel.org ([209.10.41.242]:32727 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S133015AbRDKWte>;
	Wed, 11 Apr 2001 18:49:34 -0400
Subject: Re: [PATCH] i386 rw_semaphores fix
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 11 Apr 2001 23:06:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9b26el$3tr$1@cesium.transmeta.com> from "H. Peter Anvin" at Apr 11, 2001 11:06:13 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nSl8-0007e9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, the big 686 optimization is CMOV, and that one is
> ultra-pervasive.

Be careful there. CMOV is an optional instruction. gcc is arguably wrong
in using cmov in '686' mode. Building libs with cmov makes sense though 
especially for the PIV with its ridiculously long pipeline

> 

