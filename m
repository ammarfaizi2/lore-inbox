Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293348AbSCJWWB>; Sun, 10 Mar 2002 17:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293349AbSCJWVv>; Sun, 10 Mar 2002 17:21:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46610 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293348AbSCJWVo>; Sun, 10 Mar 2002 17:21:44 -0500
Subject: Re: Suspend support for IDE
To: djw@flinthills.com (Derek J Witt)
Date: Sun, 10 Mar 2002 22:37:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, djw@flinthills.com
In-Reply-To: <007f01c1c881$2eb51400$d3c02740@flinthills.com> from "Derek J Witt" at Mar 10, 2002 04:16:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kBwN-0007UE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the IDE blacklist include those drives that malfunction if they're not
> using the correct connector on the IDE ribbon cable?

Thats not something the drive is even aware of unless the cable is using 
CS (cable select) in which case its a bios/host master-slave issue
