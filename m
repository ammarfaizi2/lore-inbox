Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUAKWWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUAKWWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:22:46 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:34253 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266014AbUAKWW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:22:26 -0500
Date: Sun, 11 Jan 2004 23:22:24 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: LVM migration for 2.4->2.6, fallback path?
Message-ID: <20040111222223.GA9884@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I understand that the following three combinations work (assuming
2.4.24/2.6.1):

Userspace           Kernelspace
------------------------------------------
LVM1                2.4 LVM
LVM2                2.4 + devmapper patch
LVM2                2.6

But will LVM2 + 2.4 LVM work? LVM1 + 2.6 will not.

I presume neither works, but if there is a way, I'd like to know to save
myself some work.

Oh, and while I'm at it, what good is the "old ioctl" switch in kernel
space? I am currently trying without and it works fine with a current
LVM2 version (which is presumably how things are meant to be).

TIA,

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
