Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269246AbUICQLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269246AbUICQLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUICQLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:11:44 -0400
Received: from the-village.bc.nu ([81.2.110.252]:44948 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269246AbUICQLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:11:42 -0400
Subject: Re: Crashed Drive, libata wedges when trying to recover data
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg Stark <gsstark@mit.edu>
Cc: Brad Campbell <brad@wasp.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <877jrbtkds.fsf@stark.xeocode.com>
References: <87oekpvzot.fsf@stark.xeocode.com>
	 <4136E277.6000408@wasp.net.au> <87u0ugt0ml.fsf@stark.xeocode.com>
	 <1094209696.7533.24.camel@localhost.localdomain>
	 <87d613tol4.fsf@stark.xeocode.com>
	 <1094219609.7923.0.camel@localhost.localdomain>
	 <877jrbtkds.fsf@stark.xeocode.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094224166.8102.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 16:09:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 16:58, Greg Stark wrote:
> I've even unmounted the filesystem and tried mounting it again. Now I can't
> even mount it without generating the error.

You may well need to reset or powercycle the drive to get it back from
such a state.

> Sep  3 11:48:39 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
> Sep  3 11:48:39 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
> Sep  3 11:48:39 stark kernel: ata1: error=0x01 { AddrMarkNotFound }

"Its dead Jim". Once you get a drive that dies totally (or just keeps
posting up a hardware fail) after the error you are into forensics
(and/or backup) land. 
