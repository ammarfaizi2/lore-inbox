Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVCHX1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVCHX1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVCHXXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:23:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57050 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262178AbVCHXU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:20:26 -0500
Date: Tue, 8 Mar 2005 23:20:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2
Message-ID: <20050308232019.GA20520@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050308033846.0c4f8245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308033846.0c4f8245.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +sh-merge-updates.patch
> 
>  sh/sh64 updates

btw, it would be nice if you'd give a period of say 48 hours for
people to review non-critical patches before sending them off to
Linus.  The sh update was pretty nice, so no coplaints about this
one, but we had worse things passed on in the past.

> +open-iscsi-scsi.patch
> +open-iscsi-headers.patch
> +open-iscsi-kconfig.patch
> +open-iscsi-makefile.patch
> +open-iscsi-netlink.patch
> +open-iscsi-doc.patch
> 
>  iSCSI driver

Please don't put this in.  It's fairly experimental and just one
of three iscsi initiators we're (scsi folks) currently evaluating
for inclusion.

