Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWEaUrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWEaUrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWEaUrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:47:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:3808 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S964971AbWEaUrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:47:18 -0400
Date: Wed, 31 May 2006 16:47:16 -0400
To: Martin Hierling <martin.hierling@fh-luh.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.16.18 with general protection fault, perhaps nfsd
Message-ID: <20060531204716.GL13682@fieldses.org>
References: <20060531164707.GA19547@cc.fh-luh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531164707.GA19547@cc.fh-luh.de>
User-Agent: Mutt/1.5.11+cvs20060403
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 06:47:07PM +0200, Martin Hierling wrote:
> [4] Linux version 2.6.16.18-xen (root@defiant)

Is there a xen patch applied as well?

What are your export options?  (Output of exportfs -v)  Also,
RPC-related CONFIG options would be interesting.  (grep SUNRPC .config)
Are you using gss/krb5?

--b.
