Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286915AbRL1OBz>; Fri, 28 Dec 2001 09:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286910AbRL1OBq>; Fri, 28 Dec 2001 09:01:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30984 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286909AbRL1OBg>; Fri, 28 Dec 2001 09:01:36 -0500
Subject: Re: dd cdrom error
To: chris@gist.q-station.net (Leung Yau Wai)
Date: Fri, 28 Dec 2001 14:11:01 +0000 (GMT)
Cc: dougg@torque.net (Douglas Gilbert), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10112280937570.6257-100000@gist.q-station.net> from "Leung Yau Wai" at Dec 28, 2001 09:42:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Jxiv-0000YJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	BTW, why kernel 2.2.X will success create the ISO image of the
> same disc with the same command?

The 2.2 kernel knows that errors in the last few blocks of an ISO image are
not in fact to be counted as errors and retried. Apparently that got lost
somewhere. Maybe Jens knows ?
