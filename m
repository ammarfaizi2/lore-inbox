Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbUKSUGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUKSUGx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUKSUFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 15:05:22 -0500
Received: from web41210.mail.yahoo.com ([66.218.93.43]:65151 "HELO
	web41210.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261574AbUKSUDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 15:03:33 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=JV1ONZj0t8fNa8lUw4cqOLZFQFD3HYnSdQawqmT3z+qvxmPyYiAfsZPOEFFcWIUqyou8WNjkhD89FV/+0UQZ1iKV6ROlr07/vPMzQsRCFdsBo4tnHbHRcd85WbwH8pILAUvbntBYUOcAKuctFnQk9+wli+NB93ojWl0hjPqmcbw=  ;
Message-ID: <20041119200331.53569.qmail@web41210.mail.yahoo.com>
Date: Fri, 19 Nov 2004 12:03:31 -0800 (PST)
From: Jin Suh <jinssuh@yahoo.com>
Subject: [2.4.28] Enabling a SATA drive (sata_promise.o) with Promise Fastrak S150 TX2Plus SATA PCI card?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Dell 650/Linux-2.4.28 with a Promise Fastrak S150 TX2Plus SATA PCI
card with 2 250GB Western digital drives connected. Could anyone help me how to
enable the SATA drives? I had 2.4.25 one time and it showed me /dev/hde and
/dev/hdg but the new SATA driver should show as /dev/sdX, right?

I see libata.o and sata_promise.o modules. When I do "modprobe libata and
modprobe sata_promise", I got bunch of "Unresolved symbols". I also downloaded
ft3xx driver and didn't work too. Any idea? I rebooted the same machine with
Suse9.1 (2.6.x kernel). It loaded the libata.o and sata_promise.o and I could
see /dev/sda and /dev/sdb as SATA drives correctly. 
I also have a Intel P5 ICH5, D875PBZ with 2 SATA ports. I also could not enable
the drives with ata_piix.o. Any helps would be appreciated.

Jin


