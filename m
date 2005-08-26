Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVHZPTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVHZPTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVHZPTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:19:07 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57743 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965082AbVHZPTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:19:06 -0400
Subject: Re: Telling Linux that a SATA device has gone away
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050826144250.GA12816@srcf.ucam.org>
References: <20050826144250.GA12816@srcf.ucam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Aug 2005 16:42:59 +0100
Message-Id: <1125070980.4958.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-26 at 15:42 +0100, Matthew Garrett wrote:
> the device has been removed? hdparm's bus registration support 
> (unsurprisingly) doesn't seem to work too well on sr0

It won't work on hd* either. 2.4-ac supports drive plugging but nothing
else ever did. For the SATA case see Jeff's sata status page 8) and join
in the fun. Most of what is needed is already there. 

Alan
