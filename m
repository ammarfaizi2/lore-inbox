Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUDST0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUDST0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:26:13 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:30226 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261745AbUDST0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:26:12 -0400
Date: Mon, 19 Apr 2004 20:25:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, raven@themaw.net,
       viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
Message-ID: <20040419202538.A15701@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, raven@themaw.net,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20040418230131.285aa8ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040418230131.285aa8ae.akpm@osdl.org>; from akpm@osdl.org on Sun, Apr 18, 2004 at 11:01:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4-autofs4-2.6.0-expire-20040405.patch exports vfsmount_lock which is probably
not exactly a good design.  It's only used by autofs4_may_umount which isn't
autofs-specific at all.
