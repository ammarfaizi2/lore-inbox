Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUJWGtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUJWGtr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 02:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUJWGrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 02:47:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:15841 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S271433AbUJVQya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:54:30 -0400
Subject: Re: Linux 2.6.9-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Luca Risolia <luca.risolia@studio.unibo.it>,
       Luc Saillard <luc@saillard.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <878y9y269v.fsf@bytesex.org>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
	 <20041022092102.GA16963@sd291.sivit.org>
	 <20041022143036.462742ca.luca.risolia@studio.unibo.it>
	 <878y9y269v.fsf@bytesex.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098460282.19459.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 16:51:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-22 at 15:10, Gerd Knorr wrote:
> The corner case are the vendor-specific compressions.  IMHO it doesn't
> make much sense to attempt to implement every strange format some
> engineer invented in every v4l2 application.  Especially if there is
> no free implementation of it (which is the reason the non-gpl pwcx
> module was created IIRC).

The pwc formats look like they can be done a lot faster in MMX, which
argues for some format of user space exposure and a set of format idents
for "vendor foo, protocol 0" etc

