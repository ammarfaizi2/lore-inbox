Return-Path: <linux-kernel-owner+w=401wt.eu-S1945921AbWLVCyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945921AbWLVCyz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 21:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945922AbWLVCyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 21:54:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:55584 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945921AbWLVCyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 21:54:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hVkqeWNrgXxqE5YYt9NB5QHENg8nQ8U5Xeu74EPk3n3ePwn1l8A4hxp+WmhilTKNsu7euXBjSjngimCBM0iRq4UrE344q1w/bmGruRKLOIxsXh0l5QwHtmAZwVhiWV3sWjUwdpQt07DaNMmQ38iuzIbz+K00KFwiULRQI70JU6E=
Message-ID: <df47b87a0612211854w40f8ee3akb2a2721070878341@mail.gmail.com>
Date: Thu, 21 Dec 2006 21:54:53 -0500
From: "Ioan Ionita" <opslynx@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PATA_SIS and SIS 5513
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pata_sis will not work with my CD-ROM

dmesg output when trying to mount a cd-rom:

ata2.00: qc timeout (cmd 0xa0)
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x24)
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x28 data 4096 in
         res 51/51:03:00:00:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: qc timeout (cmd 0xa0)
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x24)
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x28 data 4096 in
         res 51/51:03:00:00:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: qc timeout (cmd 0xa0)
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x24)
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x28 data 4096 in
         res 51/51:03:00:00:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
root@section 21:52:39 ~/
