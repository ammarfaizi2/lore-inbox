Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269250AbRHGSO7>; Tue, 7 Aug 2001 14:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269262AbRHGSOu>; Tue, 7 Aug 2001 14:14:50 -0400
Received: from ns.caldera.de ([212.34.180.1]:33962 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S269250AbRHGSOj>;
	Tue, 7 Aug 2001 14:14:39 -0400
Date: Tue, 7 Aug 2001 20:12:54 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] parser for mount options
Message-ID: <20010807201254.A23539@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108071227080.18565-100000@weyl.math.psu.edu> <0108072006540A.02365@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0108072006540A.02365@starship>; from phillips@bonn-fries.net on Tue, Aug 07, 2001 at 08:06:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 08:06:54PM +0200, Daniel Phillips wrote:
> Can't think of anything to flame about, so how about a comment: strtok 
> is evil.  Even strtok_r sucks somewhat for destroying the input string 
> but strtok is far worse for keeping internal static state.  This would 
> be a good opportunity to add strtok_r to the library and use it.

strsep()

