Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTK0ClO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 21:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTK0ClN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 21:41:13 -0500
Received: from mail.inter-page.com ([12.5.23.93]:3850 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S264426AbTK0ClN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 21:41:13 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Jesse Pollard'" <jesse@cats-chateau.net>,
       "'Florian Weimer'" <fw@deneb.enyo.de>
Cc: <Valdis.Kletnieks@vt.edu>, "'Daniel Gryniewicz'" <dang@fprintf.net>,
       "'linux-kernel mailing list'" <linux-kernel@vger.kernel.org>
Subject: RE: OT: why no file copy() libc/syscall ??
Date: Wed, 26 Nov 2003 18:40:29 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAilRHd97CfESTROe2OYd1HQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <03112013081700.27566@tabby>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Among the other N objections, add things like the lack of any sort of
control or option parameters)
...
N += 1: Sparse Copying (e.g. seeking past blocks of zeros)
N += 1: Unlink or overwrite or what?
N += 1: In-Kernel locking and resolution for pages that are mandatory
lock(ed)
N += 1: No fine-grained control for concurrency issues (multiple writers)

Start with doing a cp --help and move on from there for an unbounded list of
issues that sys_copy(int fd1, int fd2) does not even come close to
addressing.



