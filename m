Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265832AbUAEBVm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 20:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUAEBVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 20:21:42 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:52705 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S265832AbUAEBVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 20:21:41 -0500
To: linux-kernel@vger.kernel.org
Subject: Relocation overflow with modules on Alpha
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 05 Jan 2004 02:21:37 +0100
Message-ID: <yw1xy8sn2nry.fsf@ford.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I compiled Linux 2.6.0 for Alpha, and it mostly works, except the
somewhat large modules.  They fail to load with the message
"Relocation overflow vs section 17", or some other section number.
I've seen this with scsi-mod, nfsd, snd-page-alloc and possibly some
more.  Compiling them statically works.  What's going on?

-- 
Måns Rullgård
mru@kth.se
