Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314495AbSDRX1F>; Thu, 18 Apr 2002 19:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314496AbSDRX1E>; Thu, 18 Apr 2002 19:27:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62472 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314495AbSDRX1D>; Thu, 18 Apr 2002 19:27:03 -0400
Subject: Re: Bio pool & scsi scatter gather pool usage
To: peloquin@us.ibm.com (Mark Peloquin)
Date: Fri, 19 Apr 2002 00:36:32 +0100 (BST)
Cc: akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org
In-Reply-To: <OFCF00F1A4.2665039D-ON85256B9F.006B755C@pok.ibm.com> from "Mark Peloquin" at Apr 18, 2002 05:58:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yLS4-0005vN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps, but calls are expensive. Repeated calls down stacked block
> devices will add up. In only the most unusually cases will there

You don't need to repeatedly query. At bind time you can compute the 
limit for any device heirarchy and be done with it. 

Alan
