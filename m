Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271673AbRICKpf>; Mon, 3 Sep 2001 06:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271674AbRICKp0>; Mon, 3 Sep 2001 06:45:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271673AbRICKpR>; Mon, 3 Sep 2001 06:45:17 -0400
Subject: Re: Editing-in-place of a large file
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Mon, 3 Sep 2001 11:48:39 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        mcelrath+linux@draal.physics.wisc.edu (Bob McElrath)
In-Reply-To: <20010903035025.B802@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Sep 03, 2001 03:50:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15drHT-0001TX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is reimplementing file system functionality in user space. 
> I'm in doubts that this is considered good design...

Keeping things out of the kernel is good design. Your block indirections
are no different to other database formats. Perhaps you think we should
have fsql_operation() and libdb in kernel 8)
