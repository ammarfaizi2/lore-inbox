Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVAKBp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVAKBp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVAKBo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:44:56 -0500
Received: from web51805.mail.yahoo.com ([206.190.38.236]:64673 "HELO
	web51805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262697AbVAKBoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:44:06 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=fMiZfPQxPwcHJzP15gjB7xeQyYAsJ9DCrSmS2LES3PCQgI4uzp4iqK4VMWyRV2FLj3bEKaIcTTZy9cpcy8xxoWfuSrwZmf4AXmMA+Oiz7Q4cQdyebI5nfmnACmxs2Uj8t4gPsk1NdtZWBdqCchw1LwXtUk/OtqBdJxVYbkNG8hk=  ;
Message-ID: <20050111014406.18739.qmail@web51805.mail.yahoo.com>
Date: Mon, 10 Jan 2005 17:44:05 -0800 (PST)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: RAM drive
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I need some assistance with creating a RAM disk of 8G
and mounting it.  I am using 2.6.10 with this
proceedure:

(ramdisk support enabled)
dd bs=512 if=/dev/zero of=/dev/ram0 count=16384000
mkfs.ext2 -m0 /dev/ram0 8192000
mount -t ext2 /dev/ram0 /ramdisk0
mount: wrong fs type, bad option, bad superblock on
/dev/ram0,
       or too many mounted file systems

I am not sure what the issue is.  It worked on the
2.4.x series.

Any help if greatly appreciated!

TIA!
Phy


		
__________________________________ 
Do you Yahoo!? 
Read only the mail you want - Yahoo! Mail SpamGuard. 
http://promotions.yahoo.com/new_mail 
