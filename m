Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbTCGT0K>; Fri, 7 Mar 2003 14:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261735AbTCGT0K>; Fri, 7 Mar 2003 14:26:10 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:24325 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261719AbTCGT0J>; Fri, 7 Mar 2003 14:26:09 -0500
Date: Fri, 7 Mar 2003 19:36:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030307193644.A14196@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Mar 07, 2003 at 08:32:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 08:32:01PM +0100, Andries.Brouwer@cwi.nl wrote:
> > IMHO that's a bad change, (un)register_blkdev should just go away
> > completly.
> 
> Yes, it would be best if the kernel became perfect at once.
> But the patch is rather large. Better go in small steps.
> 
> Did you read the patch?

Yes, I did.  What I object to is the prototype changes you did which
make absolutely no sense to get into 2.5 now when the functions will
disappear before 2.6.  Feel free to change the actual implementation,
I couldn't care less on you wasting your time on that :)

