Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVDXUNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVDXUNp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVDXUNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:13:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59066 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262375AbVDXUNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:13:43 -0400
Date: Sun, 24 Apr 2005 21:13:56 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050424201356.GJ13052@parcelfarce.linux.theplanet.co.uk>
References: <E1DPnOn-0000T0-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DPnOn-0000T0-00@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 10:08:13PM +0200, Miklos Szeredi wrote:
> Comments are appreciated.  If there are no vetoes agains the patch, I
> think it's suitable for -mm.

Vetoed.  Having suid application with different pathname resolution than
that of parent just because it is suid is not acceptable.  I'm sorry,
but breaking hell knows how many existing applications is not an option.
