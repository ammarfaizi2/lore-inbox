Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWBSWIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWBSWIp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWBSWIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:08:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38272 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751050AbWBSWIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:08:44 -0500
Date: Sun, 19 Feb 2006 22:08:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       zanussi@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] relay: Migrate from relayfs to a generic relay API.
Message-ID: <20060219220840.GA14153@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, zanussi@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060219210733.GA3682@linux-sh.org> <20060219212122.GA7974@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219212122.GA7974@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 04:21:22PM -0500, Dave Jones wrote:
> On Sun, Feb 19, 2006 at 11:07:33PM +0200, Paul Mundt wrote:
>  > This is a small patch set for getting rid of relayfs, and moving the core of
>  > its functionality to kernel/relay.c. The API is kept consistent for everything
>  > but the relayfs-specific bits, meaning people will have to use other file
>  > systems to implement relay channel buffers.
> 
> What about the userspace visible API for things already using relayfs,

There's no existing in-tree user of relayfs.

