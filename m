Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262359AbREUDGj>; Sun, 20 May 2001 23:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbREUDG3>; Sun, 20 May 2001 23:06:29 -0400
Received: from mail.ntplx.net ([204.213.176.10]:33151 "EHLO mail.ntplx.net")
	by vger.kernel.org with ESMTP id <S262359AbREUDGN>;
	Sun, 20 May 2001 23:06:13 -0400
Message-ID: <3B088516.68D57DB1@ntplx.net>
Date: Sun, 20 May 2001 23:01:42 -0400
From: Ben Bridgwater <bennyb@ntplx.net>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Background to the argument about CML2 design philosophy
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> derive MVME147_SCSI from MVME147 & SCSI

It seems that the preferred semantics would be:

default MVME147_SCSI from MVME147 & SCSI

That way the platform defines sane defaults, but no flexibility has been
taken away.

Presumably many of these defaulted options would also be ones that would
be configured not to be changeable in novice mode. The novice gets the
vanilla platform defaults without being bothered by detailed options,
and can switch to expert mode if they need more control. The experts get
all the options presented, but also get to benefit from the smart
platform defaults.

Ben
