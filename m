Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032035AbWLGLH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032035AbWLGLH5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032034AbWLGLH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:07:57 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:36807 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032033AbWLGLH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:07:56 -0500
Date: Thu, 7 Dec 2006 12:00:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 30/35] Unionfs: Helper macros/inlines
In-Reply-To: <11652354723312-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612071159530.2863@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354723312-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 4 2006 07:31, Josef 'Jeff' Sipek wrote:
>+#define ibstart(ino) (UNIONFS_I(ino)->bstart)
>+#define ibend(ino) (UNIONFS_I(ino)->bend)
>+
>+#define sbend(sb) UNIONFS_SB(sb)->bend

If you () ibstart/ibend, you may want to do the same for sbend.


	-`J'
-- 
