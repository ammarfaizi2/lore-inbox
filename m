Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310135AbSCFVq4>; Wed, 6 Mar 2002 16:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310210AbSCFVqq>; Wed, 6 Mar 2002 16:46:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59660 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310135AbSCFVqe>;
	Wed, 6 Mar 2002 16:46:34 -0500
Message-ID: <3C868E4F.53C91E8C@mandrakesoft.com>
Date: Wed, 06 Mar 2002 16:46:55 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire net driver update for 2.4.19pre2
In-Reply-To: <Pine.LNX.4.44.0203061637270.31906-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.

There is a bugfix, which I will make locally before submitting:
PCI_COMMAND_INVALIDATE should be enabled -after- messing with
PCI_CACHE_LINE_SIZE.

-- 
Jeff Garzik      | Usenet Rule #2 (John Gilmore): "The Net interprets
Building 1024    | censorship as damage and routes around it."
MandrakeSoft     |
