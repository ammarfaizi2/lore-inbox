Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267968AbUHPVrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267968AbUHPVrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 17:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267970AbUHPVrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 17:47:52 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:39685 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267968AbUHPVrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 17:47:51 -0400
Date: Mon, 16 Aug 2004 22:47:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040816224749.A15510@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040816143710.1cd0bd2c.akpm@osdl.org>; from akpm@osdl.org on Mon, Aug 16, 2004 at 02:37:10PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 02:37:10PM -0700, Andrew Morton wrote:
> - The packet-writing patches should be ready to go, but I haven't even
>   looked at them yet, and am not sure that anyone else has reviewed the code.

It's still messing with the elevator setting directly which is a no-go.
That's not the packet-writing drivers fault but needs solving first.

