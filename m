Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVKJJCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVKJJCg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVKJJCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:02:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53444 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751216AbVKJJCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:02:35 -0500
Date: Thu, 10 Nov 2005 09:02:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: [PATCH 1/4] relayfs: add support for non-relay files
Message-ID: <20051110090227.GA6358@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, karim@opersys.com
References: <17266.28430.472991.124439@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17266.28430.472991.124439@tut.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 03:50:06PM -0600, Tom Zanussi wrote:
> Hi,
> 
> Currently, the relayfs API only supports the creation of directories
> (relayfs_create_dir()) and relay files (relay_open()).  This patch
> adds support for non-relay files (relayfs_create_file()).
>     
> This is so relayfs applications can create 'control files' in relayfs
> itself rather than in /proc or via a netlink channel, as is currently
> done in the relay-app examples.  There were several comments that the
> use of netlink in the example code was non-intuitive and in fact the
> whole relay-app business was needlessly confusing.  Based on that
> feedback, the example code has been completely converted over to
> relayfs control files as supported by this patch, and have also been
> made completely self-contained.  The converted examples can be found
> here:

NACK.  please do one thing at a time in relayfs instead of adding everthing
and a kitchen sink.

