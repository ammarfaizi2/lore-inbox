Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbSKMAbv>; Tue, 12 Nov 2002 19:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267063AbSKMAbv>; Tue, 12 Nov 2002 19:31:51 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:38056 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267062AbSKMAbu>; Tue, 12 Nov 2002 19:31:50 -0500
Subject: Re: Linux v2.5.47
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <20021113002222.B323@infradead.org>
References: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com> 
	<20021113002222.B323@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 01:03:52 +0000
Message-Id: <1037149432.10083.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 00:22, Christoph Hellwig wrote:
> 	[do basic setup]
> 	sdev = scsi_register();
> 	[do more setup]
> 	return scsi_add_host();
> 
> Similarly a new routine, scsi_remove_host exist to call at the end
> of the remove routine.

Very very nice. One question - what are the rules for the
scsi_remove_host callback with regards to a hotplug ? 

