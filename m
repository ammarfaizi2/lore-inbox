Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289346AbSAVTCk>; Tue, 22 Jan 2002 14:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289354AbSAVTCa>; Tue, 22 Jan 2002 14:02:30 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:34721 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289346AbSAVTCM>; Tue, 22 Jan 2002 14:02:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: jan.ciger@epfl.ch, Samuel Maftoul <maftoul@esrf.fr>
Subject: Re: umounting
Date: Tue, 22 Jan 2002 20:01:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020122150703.B13509@pcmaftoul.esrf.fr> <m16T2IB-02103HC@ligsg2.epfl.ch>
In-Reply-To: <m16T2IB-02103HC@ligsg2.epfl.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16T6BH-1ZiPWiC@fwd07.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When a second user comes and unmounts a disk, then the data are flushed
> (the old data) and he gets a fs corruption, because the data were not from
> his disk.

No. The sbp2 driver should report a disk change. If such a thing happens,
there's a kernel bug. Pulling out a mounted disk may cause a corrupted
filesystem on that disk but not on others.

	Regards
		Oliver
