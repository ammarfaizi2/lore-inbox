Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVG1OV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVG1OV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVG1OTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:19:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43914 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261429AbVG1ORu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:17:50 -0400
Date: Thu, 28 Jul 2005 15:17:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: ericvh@gmail.com
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc3-mm2] v9fs: add fd based transport
Message-ID: <20050728141749.GB22173@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, ericvh@gmail.com,
	linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
	akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <200507281358.j6SDwBRZ026263@ms-smtp-03-eri0.texas.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507281358.j6SDwBRZ026263@ms-smtp-03-eri0.texas.rr.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 08:57:23AM -0500, ericvh@gmail.com wrote:
> v9fs: add file-descriptor based transport as was requested by LANL and
> Plan 9 from User Space folks.

Couldn't the two other transports be implemented ontop of this one using
a mount helper doing the pipe or tcp setup?

