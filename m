Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWIZQBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWIZQBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWIZQBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:01:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12956 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932233AbWIZQBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:01:14 -0400
Date: Tue, 26 Sep 2006 17:00:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [SYSFS] Add a declaration for fs_subsys
Message-ID: <20060926160043.GA2402@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>, gregkh@suse.de,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1159274711.11901.460.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159274711.11901.460.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 01:45:11PM +0100, Steven Whitehouse wrote:
> 
> The fs_subsys of sysfs does not have a declaration in any header
> file, despite it being an exported symbol. This patch adds one so
> that modules don't have to add their own. This is something used
> by GFS2 (and already in the GFS2 tree) but I think can safely be
> considered generic infrastructure.

The declaration seem to be already present in Linus' current tree.

