Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTIYLTQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTIYLTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:19:16 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:38158 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261799AbTIYLTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:19:15 -0400
Date: Thu, 25 Sep 2003 12:19:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix non-modular ftape compile
Message-ID: <20030925121913.A10483@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
References: <20030925102309.GI15696@fs.tum.de> <20030925113816.A9693@infradead.org> <20030925110325.GK15696@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030925110325.GK15696@fs.tum.de>; from bunk@fs.tum.de on Thu, Sep 25, 2003 at 01:03:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 01:03:25PM +0200, Adrian Bunk wrote:
> It increases the kernel size since in 2.6 __exit functions are discarded 
> at runtime and not at link time.

Oh.  That sounds silly.  Do you remember who changed it and why?

