Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265524AbTFRUnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbTFRUnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:43:23 -0400
Received: from ns.suse.de ([213.95.15.193]:34060 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265524AbTFRUnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:43:22 -0400
Date: Wed, 18 Jun 2003 22:57:19 +0200
From: Andi Kleen <ak@suse.de>
To: Bruce Allan <bruce.allan@us.ibm.com>
Cc: trond.myklebust@fys.uio.no, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support non reserved ports for NFS client
Message-ID: <20030618205719.GA3543@wotan.suse.de>
References: <OF90A826B7.444525BC-ON88256D49.006D66FE-88256D49.006E8344@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF90A826B7.444525BC-ON88256D49.006D66FE-88256D49.006E8344@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 01:07:05PM -0700, Bruce Allan wrote:
> May I make the suggestion that instead of creating a new flag (i.e.
> NFS_MOUNT_NONRESERVED) and using a new bit in the flags field of struct
> nfs_mount_data, Andi use the already existing and unused NFS_MOUNT_SECURE
> assuming that is what was originally intended for this bit.  This would
> also match in name with the secure/insecure export option on the server.

Makes sense yes. Thanks for the suggestion.

-Andi
