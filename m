Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWAJLkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWAJLkD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 06:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWAJLkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 06:40:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48873 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751057AbWAJLkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 06:40:01 -0500
Date: Tue, 10 Jan 2006 03:39:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tetsuo Handa <from-linux-kernel@I-love.SAKURA.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15] EXPORT_SYMBOL(__rcuref_hash);
Message-Id: <20060110033945.065afbe8.akpm@osdl.org>
In-Reply-To: <200601102008.CIJ48967.MYPFJGSMtNtVOLSFO@I-love.SAKURA.ne.jp>
References: <200601102008.CIJ48967.MYPFJGSMtNtVOLSFO@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa <from-linux-kernel@I-love.SAKURA.ne.jp> wrote:
>
> Some kernel modules (for example, unionfs.ko) need __rcuref_hash,
>  but __rcuref_hash is not exported.

__rcuref_hash[] just got deleted.
