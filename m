Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291022AbSAaLlf>; Thu, 31 Jan 2002 06:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291024AbSAaLlZ>; Thu, 31 Jan 2002 06:41:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36108 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291022AbSAaLlV>; Thu, 31 Jan 2002 06:41:21 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 31 Jan 2002 11:53:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hch@ns.caldera.de (Christoph Hellwig),
        linux-kernel@vger.kernel.org, torvalds@transmeta.com, axboe@suse.de
In-Reply-To: <3C59297C.20607@evision-ventures.com> from "Martin Dalecki" at Jan 31, 2002 12:24:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WFmm-0001wT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No you are wrong. This array is supposed to provide a readahead setting 
> on the driver level, which is bogous, since
> it's something that *should* not be exposed to the upper layers at all. 

Right.

>  we have already max_readahead in struut block_device as well. Please 
> note that this array only has

Ok. Now I look at it again yes - the array is completely surplus to current
requirements. 2.5 nicely sorts out the queues 


