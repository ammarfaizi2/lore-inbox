Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270524AbTGSIM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 04:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270525AbTGSIM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 04:12:58 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:64264 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270524AbTGSIM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 04:12:57 -0400
Date: Sat, 19 Jul 2003 09:27:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre7aa1
Message-ID: <20030719092754.C19754@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20030719013223.GA31330@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030719013223.GA31330@dualathlon.random>; from andrea@suse.de on Sat, Jul 19, 2003 at 03:32:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 03:32:23AM +0200, Andrea Arcangeli wrote:
> Only in 2.4.22pre7aa1: 72_22pre7-broke-the-vmap-api-1
> 
> 	Adapt xfs to the slightly different vmap API in 22pre7.

Umm, XFS already expects the new vmap API but you patched the old one
back in in 71_xfs-aa-4 :)

