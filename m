Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVDURBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVDURBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVDURBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:01:53 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:49382 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261551AbVDURAw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:00:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C+6RtjJpJ4uBbXd4o9xqBIXFRFuCG8QwRACw6BdaIQedM9ThNSowlL7ELzXxXbDNtkkNqgzKdYyGC0sPxlvWVb6sRJFr5K0HcSB251yr95GmAVRbSc25InERwlc0rd6RKckrZFZMbsIKrrV7QD61WfAjkPBAERDgXws+Cb891XU=
Message-ID: <b6408ebf050421100075af6800@mail.gmail.com>
Date: Thu, 21 Apr 2005 17:00:51 +0000
From: Antonio Nevado <anevado@gmail.com>
Reply-To: Antonio Nevado <anevado@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Gentoo livecd - unionfs module problem
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

i´m working on a linux livecd gentoo-based using the 
linux-live scripts.

Ok, then, i use the gentoo kernel 2.6.11 with squashfs support
(not module, incore) and i compile the unionfs.ko module.
I gzip the module unionfs.ko and i copy it to the:

  kernel-modules/'uname -r'/

directory for a future use by the linux-live scripts.

Then, the scipts copy unionfs.ko.gz to the initrd.

The problem is: when the initrd boots and it try to load
the module (from /tmp when it´s already gunzipped) returns this
message:

insmod: cannot open module '/tmp/unionfs.ko' :
Invalid module format(-1): Exec format error

but if i try to load the module on the gentoo distribution before
create the .iso and burn´it (on the hard-disk) there´s no
problem (i load it with the same 'busybox' binary that uses the
linuxrc script)

Then, errors, kernel panic, goodbye...

Help! Please...

Thanks !!!

---nevy---
