Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263367AbTJKSSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 14:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbTJKSSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 14:18:25 -0400
Received: from www.bardstown.com ([209.215.186.5]:48351 "EHLO
	mail.bardstown.com") by vger.kernel.org with ESMTP id S263367AbTJKSSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 14:18:24 -0400
Message-Id: <200310111817.h9BIHvB31485@mail.bardstown.com>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com, kernel@kolivas.org, owen@bardstown.com
From: owen@bardstown.com
Subject: Kernel Panic on 2.6.0-test5 with XFS filesystem
Date: Sat, 11 Oct 2003 18:18:00 GMT
X-Mailer: Endymion MailMan Standard Edition v3.0.33
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon an upgrade from the 2.4.22-AC4 series kernel to the 2.6.0-test5 kernel, a
serious problem was encountered. A kernel panic occured, stating that the XFS
magic number on the root partition was bad. However, 2.4.22-AC4 gave no errors
and loaded fine.

A bug was filed with Gentoo Linux, detailing this issue. The X86-Kernel team
suggested that I follow up with LKML.

References:
<http://bugs.gentoo.org/show_bug.cgi?id=30277> is the original bug report.
<http://bugs.gentoo.org/attachment.cgi?id=18863&action=view> is a copy of the
kernel config I used to build these kernels.
<http://oss.sgi.com/bugzilla/show_bug.cgi?id=282> is a bug report filed against
SGI's XFS team.

This problem was encountered on:
2.4.20 kernels Con Kolivas built
2.6.0-test5 kernel
Gentoo's 2.4.20-gaming-r5 kernel

This problem was NOT encountered on:
2.4.22-ac4 kernel

Any followup would be nice :) I have CC'ed the SGI XFS team and Con Kolivas.
***Please CC me on any followup reports. I am not suscribed.***

My sincerest apologies if this is a duplicate report. I STFW many times, but saw
nothing similar.

-o

--
Owen Marshall
Systems Administration, Bardstown Internet
(502)349-9444
x106

