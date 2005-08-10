Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVHJKd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVHJKd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVHJKdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:33:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1447 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932571AbVHJKdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:33:11 -0400
Date: Wed, 10 Aug 2005 11:32:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050810103256.GA6127@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lars Marowsky-Bree <lmb@suse.de>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	David Teigland <teigland@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050802071828.GA11217@redhat.com> <20050809152045.GT29811@parcelfarce.linux.theplanet.co.uk> <20050810070309.GA2415@infradead.org> <20050810103041.GB4634@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810103041.GB4634@marowsky-bree.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 12:30:41PM +0200, Lars Marowsky-Bree wrote:
> On 2005-08-10T08:03:09, Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > Kindly lose the "Context Dependent Pathname" crap.
> > Same for ocfs2.
> 
> Would a generic implementation of that higher up in the VFS be more
> acceptable?

No.  Use mount --bind

