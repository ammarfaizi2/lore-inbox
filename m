Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317426AbSFLHw7>; Wed, 12 Jun 2002 03:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317664AbSFLHw6>; Wed, 12 Jun 2002 03:52:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47876 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317426AbSFLHwz>; Wed, 12 Jun 2002 03:52:55 -0400
Subject: Re: Cache-attribute conflict bug in the kernel exposed on newer AMD
To: richard.brunner@amd.com
Date: Wed, 12 Jun 2002 09:14:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <39073472CFF4D111A5AB00805F9FE4B609BA666B@txexmta9.amd.com> from "richard.brunner@amd.com" at Jun 10, 2002 11:17:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I3H6-00079e-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As an aside the probable speculation cause was a bug in the mmx memcpy
which in 2.4.18 and earlier prefetched beyond the copy.

