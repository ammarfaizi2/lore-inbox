Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264785AbUDWMKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264785AbUDWMKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 08:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264786AbUDWMKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 08:10:15 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:56845 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264785AbUDWMKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 08:10:12 -0400
Date: Fri, 23 Apr 2004 13:10:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <mszeredi@inf.bme.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fmount system call
Message-ID: <20040423131003.A1218@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <mszeredi@inf.bme.hu>, Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <200404221054.i3MAsOJ06500@kempelen.iit.bme.hu> <20040422124503.A20320@infradead.org> <200404221159.i3MBxRj25484@kempelen.iit.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200404221159.i3MBxRj25484@kempelen.iit.bme.hu>; from mszeredi@inf.bme.hu on Thu, Apr 22, 2004 at 01:59:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 01:59:27PM +0200, Miklos Szeredi wrote:
> > While I like the idea of fmount I think we should use the chance to untangle
> > the mess the other mount paramters are.
> 
> OK.  Do you have a suggestion for a better interface?

 - untangle the flags mess.  --bind or --move are really different operations
   than the normal mount.  separate vfs flags from filesystem flags.

maybe Al has some more ideas, but this seems to be the most important issues.

