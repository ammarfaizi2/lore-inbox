Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVEKIxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVEKIxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEKIxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:53:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54442 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261933AbVEKIxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:53:05 -0400
Date: Wed, 11 May 2005 09:53:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, ericvh@gmail.com, smfrench@austin.rr.com,
       hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511085301.GC24495@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ericvh@gmail.com,
	smfrench@austin.rr.com
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu> <20050504134717.GD3562@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504134717.GD3562@admingilde.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 03:47:17PM +0200, Martin Waitz wrote:
> hoi :)
> 
> On Tue, May 03, 2005 at 04:31:35PM +0200, Miklos Szeredi wrote:
> > This (lightly tested) patch against 2.6.12-rc* adds some
> > infrastructure and basic functionality for unprivileged mount/umount
> > system calls.
> 
> most of this unprivileged mount policy can be handled by a suid
> userspace helper (e.g. pmount)

Not sanely.  It's what started this whole threads. see the threads about
fuse and the nasty cifs ioctl.

