Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSAMOzv>; Sun, 13 Jan 2002 09:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284979AbSAMOzm>; Sun, 13 Jan 2002 09:55:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21255 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284732AbSAMOz2>; Sun, 13 Jan 2002 09:55:28 -0500
Subject: Re: ugly warnings with likely/unlikely
To: Oliver.Neukum@lrz.uni-muenchen.de
Date: Sun, 13 Jan 2002 15:07:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16PjOb-0oLbCCC@fwd11.sul.t-online.com> from "Oliver Neukum" at Jan 13, 2002 01:05:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PmEA-0007Ai-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if (likely(stru->pointer))
> 
> results in an ugly warning about using pointer as int.
> Is there something that could be done against that ?

	if (likely(stru->pointer == NULL))

Perhaps ?
