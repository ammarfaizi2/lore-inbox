Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289071AbSAIWrB>; Wed, 9 Jan 2002 17:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289068AbSAIWqv>; Wed, 9 Jan 2002 17:46:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16147 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289066AbSAIWqg>; Wed, 9 Jan 2002 17:46:36 -0500
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: pbadari@us.ibm.com (Badari Pulavarty)
Date: Wed, 9 Jan 2002 22:58:05 +0000 (GMT)
Cc: bcrl@redhat.com (Benjamin LaHaise), pbadari@us.ibm.com (Badari Pulavarty),
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, andrea@suse.de
In-Reply-To: <200201091928.g09JSdH23535@eng2.beaverton.ibm.com> from "Badari Pulavarty" at Jan 09, 2002 11:28:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ORfZ-0002Zu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If it is not reasonable to fix all the brokern drivers,
> how about making this configurable (to do variable size IO) ?
> Do you favour this solution ?

We have hardware that requires aligned power of two for writes (ie 4K on
4K boundaries only). The 3ware is one example Jeff Merkey found
