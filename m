Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWDUPbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWDUPbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWDUPbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:31:12 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:47061 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932362AbWDUPbL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:31:11 -0400
In-Reply-To: <200604211655.46993.arnd@arndb.de>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com, penberg@gmail.com,
       "Pekka Enberg" <penberg@cs.helsinki.fi>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF1BB78B05.0669111D-ON42257157.005355BC-42257157.005541C9@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Fri, 21 Apr 2006 17:31:14 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 21/04/2006 17:32:10
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on 04/21/2006 04:55:46 PM:
> There was some discussion about a sysfs hierarchy for hypervisor data
> some time ago, see also http://lwn.net/Articles/176365/.
> The idea was rather similar, just for other attributes. Maybe this
> can be consolidated in some way.

Thank you for the hint! Maybe we can find someone from the xen team
to discuss this.

> Is there a strong reason why you made your own file system instead of
> using subsystem_register to add /sys/hypervisor?

The main argument was that in sysfs normally operating system local
data is provided like data for busses or devices. The hypervisor data
does not belong to one machine. It is data for several machines within
a hypervisor environment.

Michael

