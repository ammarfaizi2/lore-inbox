Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRIKNlO>; Tue, 11 Sep 2001 09:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272451AbRIKNlF>; Tue, 11 Sep 2001 09:41:05 -0400
Received: from rainbow.transtec.de ([153.94.51.2]:2322 "EHLO
	rainbow.transtec.de") by vger.kernel.org with ESMTP
	id <S272458AbRIKNkv> convert rfc822-to-8bit; Tue, 11 Sep 2001 09:40:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <15192.23109.233454.680461@gargle.gargle.HOWL>
Date: Fri, 20 Jul 2001 18:20:21 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: qlogicfc driver
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
From: Roland Fehrenbacher <Roland.Fehrenbacher@transtec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update to my previous post:

If I force a SCSI scan using

echo "scsi add-single-device 0 0 0 1" > /proc/scsi/scsi

the device is detected correctly. So it seems like a problem in the SCSI
scanning code.

Cheers,

Roland

----
Roland Fehrenbacher
transtec AG
Waldhörnlestrasse 18
D-72072 Tübingen
Tel.: +49(0)7071/703-320
Fax: +49(0)7071/703-90320
EMail: Roland.Fehrenbacher@transtec.de
http://www.transtec.de
