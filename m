Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144290AbRAHQA1>; Mon, 8 Jan 2001 11:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144311AbRAHQAR>; Mon, 8 Jan 2001 11:00:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44037 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S144309AbRAHQAA>; Mon, 8 Jan 2001 11:00:00 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: stefan@hello-penguin.com
Date: Mon, 8 Jan 2001 16:01:10 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010108165541.A1186@stefan.sime.com> from "Stefan Traby" at Jan 08, 2001 04:55:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FejQ-0004pW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I prefer SuS fpathconf(), pathconf() is just a wrapper to fpathconf();

You can't implement it that way in the corner cases.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
