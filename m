Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbSLKNnQ>; Wed, 11 Dec 2002 08:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbSLKNmU>; Wed, 11 Dec 2002 08:42:20 -0500
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:28108 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267163AbSLKNld>; Wed, 11 Dec 2002 08:41:33 -0500
Date: Wed, 11 Dec 2002 06:42:21 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: patch for aty128fb.c
In-Reply-To: <15863.9692.239964.520652@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0212110635110.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Currently it can only put one rage 128 chip to sleep, but that is ok
> for now since I've never seen a laptop with two rage 128 chips yet. :)
> The generic device model will ultimately give us a better way to
> handle sleep/wakeup.

Actually I started to looking into doing that. I noticed struct
pci_driver having a resume and suspend function. Is this related? I just
started to looking into the new PM code.


