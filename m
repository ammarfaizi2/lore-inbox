Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268442AbRG3KHT>; Mon, 30 Jul 2001 06:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268451AbRG3KHK>; Mon, 30 Jul 2001 06:07:10 -0400
Received: from xsmtp.ethz.ch ([129.132.97.6]:9669 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S268442AbRG3KG7> convert rfc822-to-8bit;
	Mon, 30 Jul 2001 06:06:59 -0400
content-class: urn:content-classes:message
Subject: Re: [PCI] building PCI IDs/drivers DB from Linux kernel sources
Date: Mon, 30 Jul 2001 12:04:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <3B65314A.6060707@debian.org>
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Thread-Topic: [PCI] building PCI IDs/drivers DB from Linux kernel sources
Thread-Index: AcEY31itZMr6q4TREdWZGwCQJ4nSeQ==
From: "Giacomo Catenazzi" <cate@debian.org>
To: <thierry@cri74.org>
Cc: "Debian boot mailing list" <debian-boot@lists.debian.org>,
        <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Jul 2001 10:07:02.0707 (UTC) FILETIME=[60FD4830:01C118DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello.

I've already done something and it should be included on kernel 2.5,
with my
autoprobe configuration utility.
The sources are in
http://people.debian.org/~cate/files/kautoconfigure/autoconfigure/
(note that autoconfigure.rule is a simple bash script, so you can
extract
and transform data in a few shell commands)

My format is:
   check_pci 'PCI_ID' NAME_OF_CONFIG # kernel/file
where PCI_ID is a regexp of the form:
   vendor_id, device_id, subvendor_id, subdevice_id; class, interface
(mail me for further details)

Note you should manually enter the devices, because there are a lot of
exceptions:
motherboard workaround in drivers,...


(I will chek you program and maybe I would stole some of your result, It
is GPL?)

	giacomo

