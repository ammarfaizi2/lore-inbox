Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274575AbRITRhh>; Thu, 20 Sep 2001 13:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274576AbRITRh1>; Thu, 20 Sep 2001 13:37:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28684 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274575AbRITRhM>; Thu, 20 Sep 2001 13:37:12 -0400
Subject: Re: [PATCH] fix register_sysrq() in 2.4.9++
To: rddunlap@osdlab.org (Randy.Dunlap)
Date: Thu, 20 Sep 2001 18:41:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan), torvalds@transmeta.com (Linus),
        linux-kernel@vger.kernel.org (lkml), sfr@canb.auug.org.au,
        crutcher+kernel@datastacks.com
In-Reply-To: <3BAA107E.4F2FDEE2@osdlab.org> from "Randy.Dunlap" at Sep 20, 2001 08:51:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15k7pZ-0005i0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

u> +
> +static inline int register_sysrq_key(int key, struct sysrq_key_op *op_p)
> +{
> +	return -1;
> +}

make it report ok as other non compiled in stuff does - then you can avoid
masses of ifdefs
