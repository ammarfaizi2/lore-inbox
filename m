Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbUK2VdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbUK2VdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 16:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbUK2VdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 16:33:21 -0500
Received: from smtp06.auna.com ([62.81.186.16]:37258 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261808AbUK2VdS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 16:33:18 -0500
Date: Mon, 29 Nov 2004 21:33:16 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: cdrecord dev=ATA cannont scanbus as non-root
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.6
Message-Id: <1101763996l.13519l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I'm trying to get out of the mess that cd burning looks like nowadays in
linux...

As I use a 2.6.x kernel, I folowed this hints:
- no suid cdrecord, it uses capabilities
- make the burner owned by console user (pam)

cdrecord burns ok using dev=/dev/burner, but I can't get GUI tools to
burn using the /dev interface. All of them try to load ide-scsi, and
do a scan based on ATAPI:.
Some tools try to scan with dev=ATA:x:y:z, but that does not work as
normal user.

How can I make 'cdrecord dev=ATA -scanbus' work as non-root ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


