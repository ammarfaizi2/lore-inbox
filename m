Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaJoG>; Sun, 31 Dec 2000 04:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbQLaJn5>; Sun, 31 Dec 2000 04:43:57 -0500
Received: from hera.cwi.nl ([192.16.191.1]:51903 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129324AbQLaJny>;
	Sun, 31 Dec 2000 04:43:54 -0500
Date: Sun, 31 Dec 2000 10:13:26 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Ton Hospel <linux-kernel@ton.iguana.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: multiple mount of devices possible 2.4.0-test1 - 2.4.0-test13-pre4
Message-ID: <20001231101326.A8622@veritas.com>
In-Reply-To: <Pine.GSO.4.21.0012301829190.4082-100000@weyl.math.psu.edu> <92m8ht$u05$1@post.home.lunix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <92m8ht$u05$1@post.home.lunix>; from linux-kernel@ton.iguana.be on Sun, Dec 31, 2000 at 03:18:21AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 03:18:21AM +0000, Ton Hospel wrote:

> I was talking about avoiding that the same device gets multiple mounted 
> at the SAME place, e.g. when doing mount -a, which is often used as a
> quick way to get the new entries in /etc/fstab

You get EBUSY if you try.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
