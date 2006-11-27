Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758286AbWK0P36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758286AbWK0P36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 10:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758288AbWK0P36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 10:29:58 -0500
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:14785 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1758286AbWK0P35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 10:29:57 -0500
Date: Mon, 27 Nov 2006 10:29:54 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Akinobu Mita <akinobu.mita@gmail.com>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: fix dentry_open() error check
In-Reply-To: <20061127061648.GA20065@APFDCB5C>
Message-ID: <XMMS.LNX.4.64.0611271029290.28736@d.namei>
References: <20061127061648.GA20065@APFDCB5C>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006, Akinobu Mita wrote:

> The return value of dentry_open() shoud be checked by IS_ERR().
> 
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: James Morris <jmorris@namei.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Thanks.

Applied to:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6#fixes



-- 
James Morris
<jmorris@namei.org>
