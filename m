Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbUBXLCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 06:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbUBXLCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 06:02:24 -0500
Received: from a213-22-30-111.netcabo.pt ([213.22.30.111]:17536 "EHLO
	r3pek.homelinux.org") by vger.kernel.org with ESMTP id S262185AbUBXLCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 06:02:22 -0500
Message-ID: <28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
In-Reply-To: <20040224160341.GA11739@in.ibm.com>
References: <20040224160341.GA11739@in.ibm.com>
Date: Tue, 24 Feb 2004 11:02:21 -0000 (WET)
Subject: kexec "problem"
From: "Carlos Silva" <r3pek@r3pek.homelinux.org>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi guys,

i have just compiled a kernel with the kexec patch. compiled kexec-tools
and when i try to load a kernel, it gives me this:
# ./do-kexec.sh /boot/bzImage-2.6.2-g
kexec_load failed: Invalid argument
entry       = 0x91764
nr_segments = 2
segment[0].buf   = 0x80b3480
segment[0].bufsz = 1880
segment[0].mem   = 0x90000
segment[0].memsz = 1880
segment[1].buf   = 0x40001008
segment[1].bufsz = 19795a
segment[1].mem   = 0x100000
segment[1].memsz = 19795a

anyone tried to run kexec and actually did it? i'm trying with kernel 2.6.3
