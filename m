Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWECOXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWECOXn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWECOXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:23:43 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:27257 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965193AbWECOXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:23:42 -0400
In-Reply-To: <1146665860.2661.21.camel@localhost>
Subject: Re: [PATCH] s390: Hypervisor File System
To: mschwid2@de.ibm.com
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       mschwid2@de.ibm.com, Pekka J Enberg <penberg@cs.Helsinki.FI>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF5E632A7B.34B50D9A-ON42257163.004ED910-42257163.004F1570@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 3 May 2006 16:23:48 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/05/2006 16:24:50
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mschwid2@de.ltcfwd.linux.ibm.com wrote on 05/03/2006 04:17:40 PM:
> And the user space then uses the parser only? Is now the parser
> interface the "ABI" or the kernel interface that is in turn used by the
> parser? And what happens if somebody comes up with a "better" parser
> that does things subtly different?

The ABI is not defined by the Parser. You have to specify the
tag language, which is part of the ABI. Any parser, which is comliant
to the specification of the tag language can be used.


