Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314613AbSEKJW6>; Sat, 11 May 2002 05:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314637AbSEKJW5>; Sat, 11 May 2002 05:22:57 -0400
Received: from imladris.infradead.org ([194.205.184.45]:44300 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314613AbSEKJW5>; Sat, 11 May 2002 05:22:57 -0400
Date: Sat, 11 May 2002 10:22:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: [PATCH] iget-locked [2/6]
Message-ID: <20020511102245.A24305@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, kaos@ocs.com.au
In-Reply-To: <Pine.LNX.4.44.0205102120210.11642-100000@chaos.physics.uiowa.edu> <3950.1021085326@ocs3.intra.ocs.com.au> <20020511030437.GA29392@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 11:04:37PM -0400, Jan Harkes wrote:
> A backport is not that likely. The patch removes iget4 and as a result
> breaks compatibility for binary-only kernel modules that use iget and/or
> iget4. So, I don't believe this patch is appropriate for a stable series.

Part of that patchseries (an not, it's not iget4 removal :)) is likely to be
backported at least into the 2.4 XFS tree.  I guess it will also end up in
the mainline at some point.

