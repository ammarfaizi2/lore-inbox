Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTHYTjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTHYTja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:39:30 -0400
Received: from www.13thfloor.at ([212.16.59.250]:3020 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262161AbTHYTiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:38:24 -0400
Date: Mon, 25 Aug 2003 21:38:37 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [OT] sizeof C types ...
Message-ID: <20030825193837.GB28525@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20030825191339.GA28525@www.13thfloor.at> <20030825202721.A10828@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030825202721.A10828@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 08:27:21PM +0100, Christoph Hellwig wrote:
> > char,
> 
> 8 bits
> 
> > short,
> 
> 16 bits
> 
> > int,
> 
> 32 bits
> 
> > long,
> 
> either 32 or 64 bits
> 
> > long int,
> 
> dito. long is just the short form of long int
> 
> > long long, ...
> 
> 64 bits

thanks, almost figured that, but I'm looking for
a tabular info where the different architectures
are present like the folowing:

	      i386 | ia64 | alpha | sparc | wossname ...
-----------+-------+------+-------+-------+-------------------
char	   |     8 |      |       |       |
short      |    16 |      |       |       |
int        |    32 |      |       |       |
long       |    32 |      |       |       |
long long  |    64 |      |       |       |

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
