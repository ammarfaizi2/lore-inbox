Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271936AbRIDKsl>; Tue, 4 Sep 2001 06:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271940AbRIDKsV>; Tue, 4 Sep 2001 06:48:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50697 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271936AbRIDKsF>; Tue, 4 Sep 2001 06:48:05 -0400
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs
To: davem@redhat.com (David S. Miller)
Date: Tue, 4 Sep 2001 11:52:04 +0100 (BST)
Cc: ak@suse.de, jeffm@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010904.030454.85412225.davem@redhat.com> from "David S. Miller" at Sep 04, 2001 03:04:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15eDoK-0003NI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can also almost guarentee you that the x86 will sometimes not
> execute these bitops atomically on SMP.

unaligned operations are indeed generally not atomic on x86.

