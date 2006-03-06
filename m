Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWCFWJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWCFWJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWCFWJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:09:29 -0500
Received: from mxout1.netvision.net.il ([194.90.9.20]:28488 "EHLO
	mxout1.netvision.net.il") by vger.kernel.org with ESMTP
	id S932391AbWCFWJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:09:26 -0500
Date: Tue, 07 Mar 2006 00:09:53 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: Re: Re: problems with scsi_transport_fc and qla2xxx
In-reply-to: <20060306212835.GO6278@andrew-vasquezs-powerbook-g4-15.local>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Mike Snitzer <snitzer@gmail.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <1229893529.20060307000953@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
References: <1413265398.20060227150526@netvision.net.il>
 <978150825.20060227210552@netvision.net.il>
 <20060228221422.282332ef.akpm@osdl.org> <4406034B.9030105@madness.at>
 <20060301210802.GA7288@spe2> <957728045.20060302193248@netvision.net.il>
 <170fa0d20603061200y38315a62uf143258c79659381@mail.gmail.com>
 <1119462161.20060306230951@netvision.net.il>
 <20060306212835.GO6278@andrew-vasquezs-powerbook-g4-15.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!
After applying the patch the same lock exists:
#001:             [ffff81006edc4080] {scsi_host_alloc}
.. held by:         scsi_wq_4: 4255 [ffff81007edaf770, 110]
... acquired at:               scsi_scan_target+0x51/0x87 [scsi_mod]

Thanks,

Maxim.


