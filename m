Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281177AbRKLXVs>; Mon, 12 Nov 2001 18:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281188AbRKLXVj>; Mon, 12 Nov 2001 18:21:39 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2034
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281177AbRKLXVe>; Mon, 12 Nov 2001 18:21:34 -0500
Date: Mon, 12 Nov 2001 15:21:23 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Frank de Lange <lkml-frank@unternet.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Abysmal interactive performance on 2.4.linus
Message-ID: <20011112152123.C32099@mikef-linux.matchmail.com>
Mail-Followup-To: Frank de Lange <lkml-frank@unternet.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011112205551.A14132@unternet.org> <3BF02BA4.D7E2D70E@mandrakesoft.com> <20011112235642.A17544@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011112235642.A17544@unternet.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 11:56:42PM +0100, Frank de Lange wrote:
[snip]
> Seems that reiserfs is the common factor here, at least on my box. This is a 35
> GB reiserfs filesystem, app 80% used, both large and small files.
> 
> As said in my previous message, the numbers themselves don't mean squat. It is
> the large delays (the fact that user+sys <<< real) which are the problem here.
> 
> Any other magic anyone wants me to perform? Hans, you reading this?
> 

Do you see/hear a lot of seeking happing during the delays?

If so, your Reiser partition is probably fragmented to hell...

IIRC this problem is being looked at, check some archives of lkml or reiser...

Mike
