Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVC2Q5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVC2Q5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVC2Q5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:57:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31402 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261244AbVC2Q5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:57:08 -0500
Date: Tue, 29 Mar 2005 17:57:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ed L Cashin <ecashin@coraid.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.11] aoe [7/12]: support configuration of AOE_PARTITIONS from Kconfig
Message-ID: <20050329165705.GA31013@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ed L Cashin <ecashin@coraid.com>, linux-kernel@vger.kernel.org,
	Greg K-H <greg@kroah.com>
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com> <1111677688.29912@geode.he.net> <20050328170735.GA9567@infradead.org> <87hdiuv3lz.fsf@coraid.com> <20050329162506.GA30401@infradead.org> <87wtrqtn2n.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wtrqtn2n.fsf@coraid.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 11:48:48AM -0500, Ed L Cashin wrote:
> I don't know if it matters now that we have udev.  When udev manages
> the device nodes it all just works,

But most peopel still don't use udev.

> If you're saying that it's bad in principal, then that's another
> story.  If that's what you mean, then it's a Linux policy issue, and
> to follow convention I'd think that we'd need another major number.
> That would be like the partitionable md devices, etc.

Yes, it's a policy issue.  We don't do this weird config option anywhere
else.

