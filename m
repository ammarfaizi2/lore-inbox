Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264537AbUFSRCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUFSRCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 13:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUFSRCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 13:02:44 -0400
Received: from [213.146.154.40] ([213.146.154.40]:61135 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264537AbUFSQ4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:56:10 -0400
Date: Sat, 19 Jun 2004 17:56:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Brian Lazara <blazara@nvidia.com>,
       Christoph Hellwig <hch@infradead.org>,
       Andrew de Quincey <adq@lidskialf.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new device support for forcedeth.c second try
Message-ID: <20040619165606.GA7754@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
	Manfred Spraul <manfred@colorfullife.com>,
	Brian Lazara <blazara@nvidia.com>,
	Andrew de Quincey <adq@lidskialf.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40D43DC3.9000909@gmx.net> <40D46758.10304@colorfullife.com> <40D46EC4.9000007@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D46EC4.9000007@gmx.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 06:50:12PM +0200, Carl-Daniel Hailfinger wrote:
> The code duplication will be addressed soon. Right now I'd like to change
> the union "u" of v1 and v2 structs to an anonymous union for better
> readability.

GCC 2.95 doesn't support anonymous unions, so we can't use it for the kernel.

