Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130007AbRBTRDj>; Tue, 20 Feb 2001 12:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129551AbRBTRD3>; Tue, 20 Feb 2001 12:03:29 -0500
Received: from t2.redhat.com ([199.183.24.243]:34043 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129191AbRBTRDW>; Tue, 20 Feb 2001 12:03:22 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A924D8A.FBEAD695@cluster-labs.de> 
In-Reply-To: <3A924D8A.FBEAD695@cluster-labs.de> 
To: Norbert Roos <norbert.roos@cluster-labs.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Probs with PCI bus master DMA to user space 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Feb 2001 17:03:16 +0000
Message-ID: <6863.982688596@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


norbert.roos@cluster-labs.de said:
>  The problem I have is: Is there an efficient way to lock the pages
> which are accessed by the DMA?

map_user_kiobuf, lock it, DMA into it, unlock it and unmap it again?

--
dwmw2


