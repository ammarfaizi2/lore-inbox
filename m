Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUEaHnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUEaHnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 03:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUEaHnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 03:43:39 -0400
Received: from [213.146.154.40] ([213.146.154.40]:18129 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263943AbUEaHnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 03:43:39 -0400
Date: Mon, 31 May 2004 08:43:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: xfs partition refuses to mount
Message-ID: <20040531074338.GA4966@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <40B8D24A.4080703@xfs.org> <Pine.GSO.4.33.0405291528450.14297-100000@sweetums.bluetronic.net> <20040531113141.A1116544@boing.melbourne.sgi.com> <yw1xk6ytbbgo.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xk6ytbbgo.fsf@kth.se>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 04:02:31AM +0200, Måns Rullgård wrote:
> > Until May 20 (just over a week ago) recovery on sparc64 (and big endian
> > 64) did not work. A fix went into xfs_bit.c thanks to Nicolas
> > Boullis. (Our XFS qa tests are routinely run on intel cpus)
> 
> What about 64-bit little endian?  I'm using XFS on Alpha, and it seems
> to be working.  Is there something I should watch out for?

64bit Little Endian is fine, it gets regular testing on Altix (IA64),
I'm also testing 32bit Big Endian, so only 64bit BE was the problem.
