Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263098AbSJGPcu>; Mon, 7 Oct 2002 11:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSJGPct>; Mon, 7 Oct 2002 11:32:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59143 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263098AbSJGPcs>;
	Mon, 7 Oct 2002 11:32:48 -0400
Date: Mon, 7 Oct 2002 16:38:27 +0100
From: Matthew Wilcox <willy@debian.org>
To: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: remove bcopy()
Message-ID: <20021007163827.L18545@parcelfarce.linux.theplanet.co.uk>
References: <20021007152510.K18545@parcelfarce.linux.theplanet.co.uk> <20021007162227.A15313@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021007162227.A15313@infradead.org>; from hch@infradead.org on Mon, Oct 07, 2002 at 04:22:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 04:22:27PM +0100, Christoph Hellwig wrote:
> Please do.  But please let the defines in XFS in place - this
> way the source stais compatible to the IRIX version.

agreed, there's a good reason to keep it there, and in the SCSI drivers
ported from BSD.  i doubt there's a good reason to keep it in rio though.

-- 
Revolutions do not require corporate support.
