Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWJLMCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWJLMCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWJLMCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:02:44 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:27049 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751332AbWJLMCn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:02:43 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17710.12002.651934.995885@gargle.gargle.HOWL>
Date: Thu, 12 Oct 2006 16:02:42 +0400
To: Andreas Schwab <schwab@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] use %p for pointers
Newsgroups: gmane.linux.kernel
In-Reply-To: <jehcy9rbyr.fsf@sykes.suse.de>
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk>
	<Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr>
	<20061011145441.GB29920@ftp.linux.org.uk>
	<452D3BB6.8040200@zytor.com>
	<17710.8478.278820.595718@gargle.gargle.HOWL>
	<jehcy9rbyr.fsf@sykes.suse.de>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000122 37d7f81f1211299600004c9c7ee4e634
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab writes:
 > Nikita Danilov <nikita@clusterfs.com> writes:
 > 
 > > man 3 printf:
 > >
 > >        p      The void * pointer argument is printed in hexadeci-
 > >               mal (as if by %#x or %#lx).
 > >
 > > so %p already has to output '0x',
 > 
 > That is an detail of this particular implementation.
 > 
 > > it's lib/vsprintf.c to blame for non-conforming behavior.
 > 
 > The standard makes it completely implementation defined.

Yes, but POSIX/SUS aside, at least we might make kernel version closer
to Linux user-level.

 > 
 > Andreas.

Nikita.

