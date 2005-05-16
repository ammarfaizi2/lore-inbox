Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVEPJe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVEPJe7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVEPJe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:34:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57767 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261503AbVEPJez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:34:55 -0400
Date: Mon, 16 May 2005 10:34:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, ericvh@gmail.com, smfrench@austin.rr.com
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050516093454.GB20696@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ericvh@gmail.com,
	smfrench@austin.rr.com
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu> <20050511084818.GA24495@infradead.org> <E1DVoK2-0001bS-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DVoK2-0001bS-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 12:20:10PM +0200, Miklos Szeredi wrote:
> > Currently we do allow bind mounts over every type of file for the super
> > user.  I think we should keep allowing that.
> 
> Yep.  I didn't change that check (first two lines of function), so it
> should work as it used to.

You're right, I misread the patch.

