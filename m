Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131215AbRBUA1u>; Tue, 20 Feb 2001 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129677AbRBUA1l>; Tue, 20 Feb 2001 19:27:41 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34311 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131167AbRBUA10>; Tue, 20 Feb 2001 19:27:26 -0500
Subject: Re: [rfc] Near-constant time directory index for Ext2
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 21 Feb 2001 00:30:05 +0000 (GMT)
Cc: phillips@innominate.de (Daniel Phillips), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10102201618520.31530-100000@penguin.transmeta.com> from "Linus Torvalds" at Feb 20, 2001 04:22:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VNAU-00014j-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> probably a bad idea to use it, because in theory at least the VFS layer
> might decide to switch the hash function around. I'm more interested in
> hearing whether it's a good hash, and maybe we could improve the VFS hash
> enough that there's no reason to use anything else..

Reiserfs seems to have done a lot of work on this and be using tea, which is
also nice as tea is non trivial to abuse as a user to create pessimal file
searches intentionally

