Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAOTE3>; Mon, 15 Jan 2001 14:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRAOTET>; Mon, 15 Jan 2001 14:04:19 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:31130 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129532AbRAOTEJ>; Mon, 15 Jan 2001 14:04:09 -0500
Importance: Normal
Subject: Slot Number Question
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF164CE1E4.54391C01-ON852569D5.0067049B@raleigh.ibm.com>
From: "Jack Hammer" <jhammer@us.ibm.com>
Date: Mon, 15 Jan 2001 14:03:25 -0500
X-MIMETrack: Serialize by Router on D04NMS46/04/M/IBM(Release 5.0.3 (Intl)|21 March 2000) at
 01/15/2001 02:04:07 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My adapter configuration utility needs to instruct the user which physical
adapter needs attention ( when there may be multiple adapters in the system
).    My question is :  How do I determine the ( machine ) slot number of a
PCI adapter ?

In BIOS and other OS's this may be doneby examining the system's  PCI
Routing Tables.    I don't think I can get to those from Linux.

PCI Devices are defined by  BUS,  DEVICE, and FUNCTION.    In Linux there
is a function ( defined in pci.h near the end of the file ) called   "
PCI_SLOT( devfn ) "   but from what I can see this returns what PCI calls
the device.   PCI device is not the machine's slot number.   This function
even uses the encoded byte which is named  devfn  ( I assume from PCI
device and PCI function ) ,   but this function treats it as slot and
function.

Any help is appreciated.  Thanks in advance.

Jack L. Hammer
RAID Client/Server Development
IBM Personal Systems Group
(919)-254-8665

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
