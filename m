Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbUBRLDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUBRLDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:03:23 -0500
Received: from sea2-dav22.sea2.hotmail.com ([207.68.164.79]:16648 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264339AbUBRLDU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:03:20 -0500
X-Originating-IP: [80.204.235.254]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: ReiserFS corruption with samba 3.0.2a
Date: Wed, 18 Feb 2004 12:03:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
Message-ID: <Sea2-DAV22IBirXXeQM0000aeb5@hotmail.com>
X-OriginalArrivalTime: 18 Feb 2004 11:03:10.0126 (UTC) FILETIME=[CB8964E0:01C3F60E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm experimenting this problem with samba 3.0.2a and linux 2.4.24
with ReiserFS. When I copy (put) a large file (5GB) from a Windows NT
terminal server edition sp6a machine to the samba-linux box I get this
error:

Feb 17 18:01:11 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:4999052)[dev:blocknr]: bit already cleared
Feb 17 18:01:11 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:4997935)[dev:blocknr]: bit already cleared
Feb 17 18:02:48 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:902445)[dev:blocknr]: bit already cleared
Feb 17 18:02:48 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:902286)[dev:blocknr]: bit already cleared

Samba 2.2.8a doesn't show this behaviour.

The linux box is Slackware 9.1 (gcc 3.2.3 linux 2.4.24 glibc 2.3.2).
It's easy for me to reproduce the problem.

Hints?

Please CC me I'm not subscribed to the list.
