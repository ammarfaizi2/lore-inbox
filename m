Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbUKBXnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbUKBXnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbUKBW5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:57:52 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:11271 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262402AbUKBW41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:56:27 -0500
Date: Tue, 2 Nov 2004 22:56:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 8/10] CRIS architecture update - Move drivers
Message-ID: <20041102225623.GB12890@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mikael Starvik <mikael.starvik@axis.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <BFECAF9E178F144FAEF2BF4CE739C668014C748C@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668014C748C@exmail1.se.axis.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 02:04:51PM +0100, Mikael Starvik wrote:
> This is a shell script to move drivers from arch/cris/arch-v10/drivers to
> e.g. drivers/net/cris/v10. This must be applied after patch 1-7 and before
> patch 9.
> 
> Let me know if you prefer this as a big diff instead.

Given that you have only a handfull drivers those subdirectories don't
make sense.  Just give the drivers sane names and move them directly
to the appropinquate directories under drivers/

