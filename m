Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVCCApA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVCCApA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVCCAlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:41:06 -0500
Received: from smtp04.auna.com ([62.81.186.14]:21721 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S261329AbVCCAjm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:39:42 -0500
Date: Thu, 03 Mar 2005 00:39:41 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Something is broken with SATA RAID ?
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.3.0
Message-Id: <1109810381l.5754l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I posted this in other mail, but now I can confirm this.

I have a box with a SATA RAID-5, and with 2.6.11-rc3-mm2+libata-dev1
works like a charm as a samba server, I dropped it 12Gb from an
osx client, and people does backups from W2k boxes and everything was fine.
With 2.6.11-rc4-mm1, it hangs shortly after the mac starts copying
files. No oops, no messages... It even hanged on a local copy (wget),
so I will discard samba as the buggy piece in the puzzle.

I'm going to make a definitive test with rc5-mm1 vs rc5-mm1+libata-dev1.
I already know that plain rc5-mm1 hangs. I have to wait the md reconstruction
of the 1.2 TB to check rc5-mm1+libata (and no user putting things there...)

But, anyone has a clue about what is happening ? I have seen other
reports of RAID related hangs... Any important change after rc3 ?
Any important bugfix in libata-dev1 ? Something broken in -mm ?

More details, like sata card model and setup on demand...

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam10 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


