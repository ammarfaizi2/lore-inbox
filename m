Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274832AbTHAUjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 16:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272921AbTHAUjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 16:39:52 -0400
Received: from mail0.lsil.com ([147.145.40.20]:43716 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S272431AbTHAUju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 16:39:50 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E570185F3DA@EXA-ATLANTA.se.lsil.com>
From: "Mukker, Atul" <atulm@lsil.com>
To: "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Cc: "Mukker, Atul" <Atulm@lsil.com>, "Jose, Manoj" <Manojj@lsil.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "Jarrett, Peter B." <Peterj@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>
Subject: [ANNOUNCE] megaraid linux driver version 2.00.7
Date: Fri, 1 Aug 2003 16:39:20 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MegaRAID driver version 2.00.7 is released and can be download from

ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.7/

Changes from 2.00.6:

i.	Adapter lock re-definition so that patch for kernels w/o per host
lock
	is less intrusive - Jens Axboe <axboe@suse.de>

ii.	While in abort and reset handling, check for non-empty pending list
is
	invalid. The intent is to wait for pending commands in FW to
complete,
	not the pending commands with the driver - Atul Mukker
<atulm@lsil.com>


Atul Mukker
Storage Systems
LSI Logic Corporation
U.S.A.
