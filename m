Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbSL2QnK>; Sun, 29 Dec 2002 11:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSL2QnK>; Sun, 29 Dec 2002 11:43:10 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:39908 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S266438AbSL2QnJ>;
	Sun, 29 Dec 2002 11:43:09 -0500
Date: Sun, 29 Dec 2002 17:51:30 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Andi Kleen <ak@muc.de>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Workaround for AMD762MPX "mouse" bug
In-Reply-To: <20021224162501.GA5363@averell>
Message-ID: <Pine.LNX.4.51.0212291740370.6055@ally.lammerts.org>
References: <20021224162501.GA5363@averell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Dec 2002, Andi Kleen wrote:
> This patch checks later during the pci quirks pass instead
> and then tells the user to pass a kernel option - "vgaguard" - in
> case of instability.

Why not create a more general option instead, like
"reserve_mem=4k@636k"?

Eric
