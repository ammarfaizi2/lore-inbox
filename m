Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268723AbUIGWxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268723AbUIGWxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268724AbUIGWxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:53:35 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:36359 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268723AbUIGWxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:53:34 -0400
Date: Tue, 7 Sep 2004 23:53:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Tweedie <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mingming Cao <cmm@us.ibm.com>, pbadari@us.ibm.com,
       Ram Pai <linuxram@us.ibm.com>
Subject: Re: [Patch 2/6]: ext3 reservations: Renumber the ext3 reservations ioctls
Message-ID: <20040907235327.A21397@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Mingming Cao <cmm@us.ibm.com>,
	pbadari@us.ibm.com, Ram Pai <linuxram@us.ibm.com>
References: <200409071302.i87D2ROd030909@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409071302.i87D2ROd030909@sisko.scot.redhat.com>; from sct@redhat.com on Tue, Sep 07, 2004 at 02:02:27PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 02:02:27PM +0100, Stephen Tweedie wrote:
> All ext2/3 ioctls apart from these ones use 'f' as the root char for
> their macro-generated ioctl numbers; make reservations consistent with
> this.

Maybe you could reuse the XFS reservation ioctls instead of adding
another set?  Having incompatible APIs for the same thing on different
filesystems sounds like the wrong way to go.

