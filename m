Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSC0UBk>; Wed, 27 Mar 2002 15:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290713AbSC0UBa>; Wed, 27 Mar 2002 15:01:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11268 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289817AbSC0UBZ>; Wed, 27 Mar 2002 15:01:25 -0500
Subject: Re: [RFC] kmem_cache_zalloc
To: tigran@aivazian.fsnet.co.uk (Tigran Aivazian)
Date: Wed, 27 Mar 2002 20:17:14 +0000 (GMT)
Cc: sandeen@sgi.com (Eric Sandeen), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203271949230.32307-100000@euler24.homenet> from "Tigran Aivazian" at Mar 27, 2002 07:52:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qJr8-00060I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> was "standard" in some sense :)
> I wonder if they (I can't remember who it was) will say
> "kmem_cache_zalloc is a non-standard name"...

Much more useful would be kcalloc(). That way we can put all the missing 
32bit overflow checking into kcalloc and remove a lot of crud from the
kernel where we have to keep doing maths checks.

Alan
