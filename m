Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRBSBzu>; Sun, 18 Feb 2001 20:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRBSBzk>; Sun, 18 Feb 2001 20:55:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64270 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129464AbRBSBzd>; Sun, 18 Feb 2001 20:55:33 -0500
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
To: dek_ml@konerding.com
Date: Mon, 19 Feb 2001 01:55:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200102190018.f1J0IBo08575@konerding.com> from "dek_ml@konerding.com" at Feb 18, 2001 04:18:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UfYV-00029I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it had been cleared up.  In particular, the Configure.help in 2.4.2-pre4
> says "reiserfs can be used for anything that ext2 can be used for".

The configure.help is wrong on that and one other thing. NFS doesnt work
without extra patches and big endian boxes dont work with reiserfs currently

Chris - would it be worth sending me a patch that notes the NFS thing in
Configure.help and includes the patch url ?
