Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313474AbSC2QG4>; Fri, 29 Mar 2002 11:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313475AbSC2QGr>; Fri, 29 Mar 2002 11:06:47 -0500
Received: from imladris.infradead.org ([194.205.184.45]:48390 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313473AbSC2QGe>; Fri, 29 Mar 2002 11:06:34 -0500
Date: Fri, 29 Mar 2002 16:06:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: davidm@hpl.hp.com
Cc: Christoph Hellwig <hch@infradead.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility
Message-ID: <20020329160618.A25410@phoenix.infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>, davidm@hpl.hp.com,
	Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20020329152314.A22333@phoenix.infradead.org> <15524.35903.821173.784043@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 07:46:07AM -0800, David Mosberger wrote:
> Christoph, why do you think the prototype for ia64 is different?

I have stopped to wonder why ia64 does things differently.

>  It's
> because it *has to be*.  In general, you can't do a backtrace without
> having the full (preserved) state of the CPU at the point of which the
> backtrace begins.

So your suggestion is to move the other architectures to the ia64 prototype
or to not have an architecture-independand stack-traceback facility at all?

	Christoph

