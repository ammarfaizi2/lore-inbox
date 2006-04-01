Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWDAXQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWDAXQD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 18:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWDAXQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 18:16:03 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13011 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932296AbWDAXQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 18:16:01 -0500
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <7873105C-8F66-4458-B669-3D6677203802@mac.com>
References: <5VqEv-46l-49@gated-at.bofh.it> <5VqEv-46l-47@gated-at.bofh.it>
	 <5WA8u-X3-5@gated-at.bofh.it> <5WAi6-19q-13@gated-at.bofh.it>
	 <5WB4M-2kX-29@gated-at.bofh.it> <442DD58B.7070801@shaw.ca>
	 <7873105C-8F66-4458-B669-3D6677203802@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Apr 2006 00:23:24 +0100
Message-Id: <1143933805.23920.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-03-31 at 21:54 -0500, Kyle Moffett wrote:
> IDE controller at a higher-than-supported speed.  It gets errors for  
> a couple seconds and automatically drops the bus down to a lower and  
> safer speed. 

This indicates a problem somewhere. The drives and controller report
their speed capabilities and if they can't meet the ones they are
reporting something is very wrong somewhere and this is most definitely
the first thing to debug.

