Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264300AbUDUJIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbUDUJIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 05:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbUDUJIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 05:08:44 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:53764 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264300AbUDUJIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 05:08:43 -0400
Date: Wed, 21 Apr 2004 10:08:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Kent <raven@themaw.net>, hch@infradead.org,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
Message-ID: <20040421100835.A3577@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Ian Kent <raven@themaw.net>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419202538.A15701@infradead.org> <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au> <20040419182657.7870aee9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040419182657.7870aee9.akpm@osdl.org>; from akpm@osdl.org on Mon, Apr 19, 2004 at 06:26:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 06:26:57PM -0700, Andrew Morton wrote:
> May as well rename that function to may_umount(), document it, suck it into
> fs/namespace.c or fs/namei.c and export it to modules.
> 
> That does increase the size of the static kernel a little, so arguably we
> shouldn't make this change until/unless we see a second user of the
> function.

That's what I meant.  Simply exporting vfsmount_lock to modules is a no-go.

