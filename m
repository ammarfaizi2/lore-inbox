Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272912AbRIGXzw>; Fri, 7 Sep 2001 19:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272915AbRIGXzm>; Fri, 7 Sep 2001 19:55:42 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:19689 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S272912AbRIGXzg>; Fri, 7 Sep 2001 19:55:36 -0400
Message-ID: <8A9A5F4E6576D511B98F00508B68C20A0BC9A2@orsmsx106.jf.intel.com>
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: dynamic arrival of scsi hosts...
Date: Fri, 7 Sep 2001 16:55:50 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

does the current linux 2.4.x series handle new controller additions.? I have
seen the new pci hotplug
interfaces, but iam not sure if the scsi midlayer can handle new controllers
showing up.?

for eg: if during scsi_register_host() i have just one controller. If i add
another one after system is up, will this 
framework be able to handle this new controller in the mix? if there is a
mechanism to do this
what should the low level hba driver writer do to make this happen.?

i have seen some hooks do add/probe new devices on the already existing
adapter, (only add, not sure if remove would work)

if someone knows the answer please reply to me.

ashokr

