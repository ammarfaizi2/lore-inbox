Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSIIOOk>; Mon, 9 Sep 2002 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSIIOOk>; Mon, 9 Sep 2002 10:14:40 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:64646
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S316586AbSIIOOk>; Mon, 9 Sep 2002 10:14:40 -0400
Date: Mon, 9 Sep 2002 07:18:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wojciech Sas Cieciwa <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: [long] 2.4.19 and O(1) Scheduler [PPC]
Message-ID: <20020909141850.GB3836@opus.bloom.county>
References: <20020906142644.GR761@opus.bloom.county> <Pine.LNX.4.44L.0209091140470.17064-100000@alpha.zarz.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209091140470.17064-100000@alpha.zarz.agh.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 12:30:08PM +0200, Wojciech Sas Cieciwa wrote:
> On Fri, 6 Sep 2002, Tom Rini wrote:
> [...]
> > 
> > You've got some incomplete PPC patch somewhere,  or you're trying to
> > compile for an IBM 40x board, which isn't supported by the kernel.org
> > trees yet.
> 
> Maybe, patch is from http://people.redhat.com/mingo/O(1)-scheduler/
> When I replace PPC405_ERR77(x, y) to dcbt x,y [I found this in 2.5]
> This part passed correctly, but I found next error in O(1) scheduler source.

Well, if you aren't compiling for an IBM 40x board, PPC405_ERR77 should
be defined to nothing.  And it also looks like the O(1) scheduler patch
you're trying lacks complete PPC support.  I would again suggest that
you use 2.4.18 or 2.4.19 and whichever O(1) patch applies to that, as I
think I've seen people using O(1) on PPC under 2.4.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
