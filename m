Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314783AbSENHWp>; Tue, 14 May 2002 03:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315241AbSENHWo>; Tue, 14 May 2002 03:22:44 -0400
Received: from imladris.infradead.org ([194.205.184.45]:782 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314783AbSENHWn>; Tue, 14 May 2002 03:22:43 -0400
Date: Tue, 14 May 2002 08:22:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove 2TB block device limit
Message-ID: <20020514082239.B15907@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20020513131339.A4610@infradead.org> <15584.23204.925373.44968@wombat.chubb.wattle.id.au> <3CE071F7.347C78B5@zip.com.au> <15584.32089.872754.245023@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 12:58:33PM +1000, Peter Chubb wrote:
> I'll let Christoph speak for himself, but my point is that
> get_block() is an interface exported from the filesystem.

It itsn't.  get_block is a callback for the generic block-based filesystem
library routines.

