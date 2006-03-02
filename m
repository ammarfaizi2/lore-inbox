Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWCBXOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWCBXOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWCBXOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:14:25 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:56549
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751717AbWCBXOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:14:24 -0500
Message-ID: <44077C56.6000506@ed-soft.at>
Date: Fri, 03 Mar 2006 00:14:30 +0100
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATA: New patch (2.6.16rc5-ide2)
References: <1141242515.23170.6.camel@localhost.localdomain> <44064FBF.2010408@comcast.net>
In-Reply-To: <44064FBF.2010408@comcast.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added { 0x8086, 0x25a2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb2_pata } to
drivers/scsi/ata_piix.c.

When i try to play a dvd i get the following errors in dmesg :

end_request: I/O error, dev sr0, sector 1411168
Buffer I/O error on device sr0, logical block 176396
Buffer I/O error on device sr0, logical block 176397
Buffer I/O error on device sr0, logical block 176398
Buffer I/O error on device sr0, logical block 176399
Buffer I/O error on device sr0, logical block 176400
Buffer I/O error on device sr0, logical block 176401
Buffer I/O error on device sr0, logical block 176402
Buffer I/O error on device sr0, logical block 176403
end_request: I/O error, dev sr0, sector 1411232
Buffer I/O error on device sr0, logical block 176404
Buffer I/O error on device sr0, logical block 176405
end_request: I/O error, dev sr0, sector 1411432
end_request: I/O error, dev sr0, sector 1411616
end_request: I/O error, dev sr0, sector 1411168

I know the DVD is ok. How can i help to make it work ?

cu

Edgar (gimli) Hucek
