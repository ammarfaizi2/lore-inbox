Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbSJCAEP>; Wed, 2 Oct 2002 20:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262691AbSJCAEP>; Wed, 2 Oct 2002 20:04:15 -0400
Received: from adsl-157-199-164.dab.bellsouth.net ([66.157.199.164]:2747 "EHLO
	midgaard.us") by vger.kernel.org with ESMTP id <S262682AbSJCAEO>;
	Wed, 2 Oct 2002 20:04:14 -0400
Date: Wed, 2 Oct 2002 19:53:49 -0400
From: Andreas Boman <aboman@nerdfest.org>
To: Mike Anderson <andmike@us.ibm.com>
Cc: akpm@digeo.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       dougg@gear.torque.net
Subject: Re: 2.4.39 "Sleeping function called from illegal context at slab.c:1374"
Message-ID: <20021002235349.GA20442@midgaard.us>
Mail-Followup-To: Mike Anderson <andmike@us.ibm.com>, akpm@digeo.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dougg@gear.torque.net
References: <3D99885B.533C320D@aitel.hist.no> <3D99EF62.3A3E6932@digeo.com> <20021001215907.GA8273@midgaard.us> <3D9A207A.14BFF440@digeo.com> <20021002162443.GA1317@beaverton.ibm.com> <20021002184437.GA17474@midgaard.us> <20021002212122.GF1317@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002212122.GF1317@beaverton.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Anderson (andmike@us.ibm.com) wrote:
> Andreas,
> 	Here is the updated patch.
> 

Yep, no more warnings on modprobe sg. Unfortenuately the box still hangs after 
modprobe ide-scsi:

 scsi1 : SCSI host adapter emulation for IDE ATAPI devices
 scsi_eh_offline_sdevs: Device set offline - notready or command retry failedafter error recovery: host1 channel 0 id 0 lun 0
   Vendor:           Model:                   Rev:     
   Type:   Direct-Access                      ANSI SCSI revision: 00
 hda: lost interrupt
 ide-scsi: CoD != 0 in idescsi_pc_intr
 hda: DMA disabled
 hda: ATAPI reset complete


andreas
