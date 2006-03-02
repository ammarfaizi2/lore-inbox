Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWCBIpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWCBIpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbWCBIpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:45:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62342 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751148AbWCBIpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:45:24 -0500
Date: Thu, 2 Mar 2006 08:45:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Sam Vilain <sam@vilain.net>
Cc: David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 1/5] NFS: Permit filesystem to override root dentry on mount [try #2]]
Message-ID: <20060302084522.GB21902@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sam Vilain <sam@vilain.net>, David Howells <dhowells@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44061705.9020105@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44061705.9020105@vilain.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 10:49:57AM +1300, Sam Vilain wrote:
> The attached patch extends the get_sb() filesystem operation to take an 
> extra argument that permits the VFS to pass in the target vfsmount that 
> defines the mountpoint.

NACK.  Filesystem has not business at all to look at the vfsmount during
mount.

