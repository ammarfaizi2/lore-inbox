Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSJMNgH>; Sun, 13 Oct 2002 09:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261525AbSJMNgH>; Sun, 13 Oct 2002 09:36:07 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:1544 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261524AbSJMNgG>; Sun, 13 Oct 2002 09:36:06 -0400
Date: Sun, 13 Oct 2002 14:41:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Peloquin <markpeloquin@hotmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       evms-devel@lists.sf.net
Subject: Re: Linux v2.5.42
Message-ID: <20021013144155.A16668@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Peloquin <markpeloquin@hotmail.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	evms-devel@lists.sf.net
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com>; from markpeloquin@hotmail.com on Sat, Oct 12, 2002 at 12:14:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 12:14:25PM -0500, Mark Peloquin wrote:
> I guess it comes down to the point of whether the block layer should evolve 
> to also handle volume management generically, or whether volume management 
> is separate component that utilizes and works with the block layer.
> 
> Linus, if you feel that volume management and the block layer can and should 
> be separate components that work together, then EVMS is ready today,

No, it's not.  Even if this design stands the code still has many issues.
Neverless even if we don't want separate representations of intermediate
volmes and topmost volumes, the voulme managment should not be part of
a driver but higher leve, i.e. separated out from the evms common library
code.

