Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291148AbSBYQIb>; Mon, 25 Feb 2002 11:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293288AbSBYQIV>; Mon, 25 Feb 2002 11:08:21 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:9387 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291148AbSBYQIC>; Mon, 25 Feb 2002 11:08:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Christian Armingeon <linux.johnny@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: knfsd not working in 2.4.18-rc4
Date: Mon, 25 Feb 2002 16:05:26 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16fLiV-0OqAvgC@fmrl03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
kernel nfsd in 2.4.18-rc4 isn't working when started via the distribution's boot scripts, and I don't know, how to set it up manually. I don't blame the distro's script, but it is a SuSE 7.3.
I think, it is a kernel issue.
2.4.17 worked, 2.4.18-rc4 was the first, who showed this misbehaviour.
Maybe, it is final relevant?

Thanks in advance,

Johnny

I get the following errors:
RPC: Unable to receive; errno = Connection refused
startproc:  exit status of parent of /usr/sbin/rpc.mountd: 1

In dmesg, I see:
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
