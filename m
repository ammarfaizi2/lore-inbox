Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267571AbTBFTPK>; Thu, 6 Feb 2003 14:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbTBFTPJ>; Thu, 6 Feb 2003 14:15:09 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:38924 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267571AbTBFTPI>; Thu, 6 Feb 2003 14:15:08 -0500
Date: Thu, 6 Feb 2003 19:24:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] fix megaraid driver compile error
Message-ID: <20030206192443.A16123@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Haverkamp <markh@osdl.org>,
	Linus Torvalds <torvalds@transmeta.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1044559247.4858.49.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1044559247.4858.49.camel@markh1.pdx.osdl.net>; from markh@osdl.org on Thu, Feb 06, 2003 at 11:20:47AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 11:20:47AM -0800, Mark Haverkamp wrote:
> This moves access of the host element to device since host has been
> removed from struct scsi_cmnd.

Any reason we can't jump straight to the v2 driver instead of fixing
the now obsolete driver?

