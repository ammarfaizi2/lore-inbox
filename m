Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLMAs0>; Tue, 12 Dec 2000 19:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbQLMAsQ>; Tue, 12 Dec 2000 19:48:16 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:56912 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129450AbQLMAsK>; Tue, 12 Dec 2000 19:48:10 -0500
Date: Wed, 13 Dec 2000 02:24:58 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Android <android@abac.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18 release notes
In-Reply-To: <20001211233956.F3199@cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0012130223560.31563-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - metrics -- L1 cacheline size is the important one: you align array
>   elements to this size when you want a per-cpu array, so that multiple
>   CPUs do not share a cacheline for accessing their "own" structure.
>   Proper alignment avoids "cacheline ping-pong", as it's called,
>   whenever two CPUs need to access "their" element of the same array at
>   the same time.

Anyone can give me some pointers on how this is done runtime ? (name of
the .c file is fine).

I'm still looking at the basic stuff, but haven't bumped into this one
yet...




	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
