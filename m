Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUHIOEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUHIOEC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUHIOEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:04:02 -0400
Received: from the-village.bc.nu ([81.2.110.252]:11465 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266574AbUHIOEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:04:00 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: eric@lammerts.org, James Bottomley <James.Bottomley@SteelEye.com>,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408091224.i79COp69009736@burner.fokus.fraunhofer.de>
References: <200408091224.i79COp69009736@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092056464.14152.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 14:01:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 13:24, Joerg Schilling wrote:
> On Linux, it is impossible to run cdrecord without root privilleges.
> Make cdrecord suid root, it has been audited....

Wrong. Although in part that is a bug in the kernel urgently needing
a fix.

> On Solaris, there is ACLs, RBAC & getppriv() / setppriv()
> 
> http://docs.sun.com/db/doc/816-5167/6mbb2jaeu?a=expand

and Linux has capabilities, ACLs and SELinux rulesets which can
also be used to manage this. I can give the cd burner a role that 
permits it certain things.

Alan

