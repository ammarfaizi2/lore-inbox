Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBVKdJ>; Thu, 22 Feb 2001 05:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129292AbRBVKc7>; Thu, 22 Feb 2001 05:32:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33808 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129159AbRBVKcy>; Thu, 22 Feb 2001 05:32:54 -0500
Subject: Re: [rfc] Near-constant time directory index for Ext2
To: hpa@transmeta.com (H. Peter Anvin)
Date: Thu, 22 Feb 2001 10:35:34 +0000 (GMT)
Cc: phillips@innominate.de (Daniel Phillips), linux-kernel@vger.kernel.org
In-Reply-To: <3A948F7B.E40C81D5@transmeta.com> from "H. Peter Anvin" at Feb 21, 2001 08:03:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Vt61-0003sC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Daniel Phillips wrote:
> > 
> > There will be a lot fewer metadata index
> > blocks in your directory file, for one thing.
> > 
> 
> Oh yes, another thing: a B-tree directory structure does not need
> metadata index blocks.

Before people get excited about complex tree directory indexes, remember to 
solve the other 95% before implementation - recovering from lost blocks,
corruption and the like
