Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262863AbSJGEsg>; Mon, 7 Oct 2002 00:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262864AbSJGEsg>; Mon, 7 Oct 2002 00:48:36 -0400
Received: from adsl-216-62-201-42.dsl.austtx.swbell.net ([216.62.201.42]:10368
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S262863AbSJGEsg>; Mon, 7 Oct 2002 00:48:36 -0400
Subject: Re: QLogic Linux failover/Load Balancing ER0000000020860
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Michael Clark <michael@metaparadigm.com>
Cc: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
In-Reply-To: <1033946058.2436.13.camel@localhost>
References: <200210061103.g96B3mlO001484@darkstar.example.net>
	 <3DA02BF2.2040506@metaparadigm.com>  <1033933235.2436.1.camel@localhost>
	 <1033946058.2436.13.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1033966448.1512.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 06 Oct 2002 23:54:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 18:14, GrandMasterLee wrote:

> I just reassigned all my LUNs to be a part of the same host
> configuration on the storage(polling by HBAs and host, versus splitting
> LUNs by HBA). I do get more than 1 LUN now, but only EVEN luns. I'll see
> if I can identify why that is. 

After defining LSI in drivers/scsi/scsi_scan.c I can get half my luns,
but still not all. I'm not sure what else I need to do. I now can see
LUNs 0,2,4,6,8, etc but not 1,3,5,7,etc. I'm not sure what else to do,
but maybe now that I've done this, I can get information from QLogic
about what should be happening. Or does this still seem like a kernel
config issue? 

TIA
> > > You just need to get the Vendor and Model info from /proc/scsi/scsi
> > > 
> > > I am using qlogic 2300s with sparse luns working fine on 2.4.18.
> > 
> > using the LB static bindings and *failover* still works?

