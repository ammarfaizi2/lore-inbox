Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310660AbSCRL3T>; Mon, 18 Mar 2002 06:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310548AbSCRL3K>; Mon, 18 Mar 2002 06:29:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62475 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293680AbSCRL3B>; Mon, 18 Mar 2002 06:29:01 -0500
Subject: Re: Linux 2.4.19-pre3-ac1
To: MrChuoi@yahoo.com
Date: Mon, 18 Mar 2002 11:44:27 +0000 (GMT)
Cc: mfedyk@matchmail.com (Mike Fedyk), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020318025233.A7C044E534@mail.vnsecurity.net> from "MrChuoi" at Mar 18, 2002 10:02:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mvYx-0004re-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - 2.4.19-pre-ac: kswapd try to swap out and access disk continuously. Whole
> system is slow down and un-interactivable.

echo "2" >/proc/sys/vm/overcommit_memory
