Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWHPOyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWHPOyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWHPOyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:54:07 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:59819 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932065AbWHPOyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:54:05 -0400
Date: Wed, 16 Aug 2006 16:52:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: Re: [PATCH 5/7] proc: Factor out an instantiate method from every
 lookup method.
In-Reply-To: <1155665132678-git-send-email-ebiederm@xmission.com>
Message-ID: <Pine.LNX.4.61.0608161650160.23266@yvahk01.tjqt.qr>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
 <1155665132678-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> 
>-out_unlock2:
>+ out:

Whoops a space. I do not mind if you put a space in front of any label, but 
at least be consistent over the whole code :)

>+#ifdef CONFIG_SECURITY
>+	inode->i_nlink += 1;
>+#endif

Maybe ++inode->i_nlink? (Same code block at another place)



Jan Engelhardt
-- 
