Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUHIPmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUHIPmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUHIPjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:39:40 -0400
Received: from the-village.bc.nu ([81.2.110.252]:30409 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266303AbUHIPge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:36:34 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, axboe@suse.de,
       eric@lammerts.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408091412.i79EC7iR010554@burner.fokus.fraunhofer.de>
References: <200408091412.i79EC7iR010554@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092062034.14154.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 15:33:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 15:12, Joerg Schilling wrote:
> >Linux has capabilities, ACLs and SELinux rulesets which can
> >also be used to manage this. I can give the cd burner a role that 
> >permits it certain things.
> 
> If you are right, why then is SuSE removing the warnings in cdrecord
> that are there to tell the user that cdrecord is running with insufficient 
> privilleges?

You'd have to ask them. Probably for the reason that most vendors
remove a lot of the other weird warnings - it confuses end users.

