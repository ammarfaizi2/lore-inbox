Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316641AbSEVSWG>; Wed, 22 May 2002 14:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316654AbSEVSWE>; Wed, 22 May 2002 14:22:04 -0400
Received: from imladris.infradead.org ([194.205.184.45]:9490 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316641AbSEVSTy>; Wed, 22 May 2002 14:19:54 -0400
Date: Wed, 22 May 2002 19:19:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] split namei.h out of fs.h
Message-ID: <20020522191945.A18584@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020522190213.A17774@infradead.org> <Pine.GSO.4.21.0205221417250.2737-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 02:18:01PM -0400, Alexander Viro wrote:
> > This patch starts with the namei/path lookup interface and splits it into
> > <linux/namei.h> which is now directly included by the 24 files that actually
> > need it.
> 
> Please, make a version that would take open_namei() and may_open() into the
> same place.

I will send an incremental patch if Linus applies this one - else it'll
be integrated when I resend.

