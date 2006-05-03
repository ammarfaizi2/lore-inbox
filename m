Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWECNiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWECNiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWECNiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:38:14 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:35848 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030205AbWECNiN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:38:13 -0400
In-Reply-To: <20060503132239.GA5250@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] s390: Hypervisor File System
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       mschwid2@de.ibm.com, Pekka J Enberg <penberg@cs.Helsinki.FI>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OFD9F4B481.11F464BA-ON42257163.004A4500-42257163.004AEB51@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 3 May 2006 15:38:19 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/05/2006 15:39:22
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörn,

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 05/03/2006 03:22:39 PM:
> On Wed, 3 May 2006 15:18:41 +0200, Michael Holzheu wrote:
> >
> o People are not forced to follow the convention.  If they don't and
>   you break an existing application, you get the blame.

Sure, but this is really just a matter of definition. The kernel defines
the ABI, right?. User space has to follow the rules. If they break the
rules
that's badluck for the userspace tools. Currently you can also
get kernel information directly from /dev/mem. If an application
does that, nobody would say, that we are not allowed to change
kernel data structures because of that user space application.

> o Now you have a dependency on the standard parser, which is in
>   userspace.  Any bug in any version of the standard parser and...

At least this parser should be well tested, if everybody uses it.

But maybe I am completely wrong here ....

Michael

