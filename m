Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314358AbSEMR5m>; Mon, 13 May 2002 13:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314377AbSEMR5l>; Mon, 13 May 2002 13:57:41 -0400
Received: from imladris.infradead.org ([194.205.184.45]:12806 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314358AbSEMR5k>; Mon, 13 May 2002 13:57:40 -0400
Date: Mon, 13 May 2002 18:57:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Elladan <elladan@eskimo.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020513185723.A2657@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Elladan <elladan@eskimo.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <elladan@eskimo.com> <200205131709.g4DH9Fjv006328@pincoya.inf.utfsm.cl> <20020513105250.A30395@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 10:52:50AM -0700, Elladan wrote:
> > It is _not_ a security feature, it is meant to keep the filesystem from
> > fragmenting too badly. root can use that space, since root can do whatever
> > she wants anyway.
> 
> But it *appears* to be a security feature.  Thus, someone might
> incorrectly depend on it, unless it's clearly documented as otherwise.

So what.  People rely on chroot() as security feature all the time and
we don't "fix" it either.  If you need security nothing but gaining
knowledge about all details helps.

