Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129993AbQKGMhs>; Tue, 7 Nov 2000 07:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbQKGMhh>; Tue, 7 Nov 2000 07:37:37 -0500
Received: from hera.cwi.nl ([192.16.191.1]:45468 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129993AbQKGMhU>;
	Tue, 7 Nov 2000 07:37:20 -0500
Date: Tue, 7 Nov 2000 13:37:09 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Joe Woodward <woodey@twasystems.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: removable EIDE disks
Message-ID: <20001107133709.A16089@veritas.com>
In-Reply-To: <000001c048ae$6132c340$6904883e@default>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <000001c048ae$6132c340$6904883e@default>; from woodey@twasystems.fsnet.co.uk on Tue, Nov 07, 2000 at 11:12:00AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 11:12:00AM -0000, Joe Woodward wrote:

> I am trying to use removable EIDE hard disks
> 
> Issuing a BLKRRPART ioctl call immediately after changing the disk works

It should not be necessary to use BLKRRPART.
Does the disk advertise itself as removable?

% dmesg | grep remov
Detected scsi removable disk sda at scsi1, channel 0, id 6, lun 0

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
