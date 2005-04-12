Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVDLH1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVDLH1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVDLH1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:27:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58027 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261975AbVDLH1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:27:35 -0400
Date: Tue, 12 Apr 2005 08:27:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Alex Aizman <itn780@yahoo.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 2/6] Linux-iSCSI High-Performance Initiator
Message-ID: <20050412072733.GA32354@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Alex Aizman <itn780@yahoo.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <425B3F58.2040000@yahoo.com> <20050412053650.GF32372@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412053650.GF32372@kroah.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 10:36:51PM -0700, Greg KH wrote:
> On Mon, Apr 11, 2005 at 08:24:08PM -0700, Alex Aizman wrote:
> >               Common header files:
> >               - iscsi_ifev.h (user/kernel events).
> 
> These structures cross the user/kernel boundry?  If so, they _must_ use
> the __u32 and friends types, not the horrible uint32_t mess...

No, C99 are just fine.
