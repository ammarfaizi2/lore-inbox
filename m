Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSEXSAZ>; Fri, 24 May 2002 14:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317238AbSEXSAY>; Fri, 24 May 2002 14:00:24 -0400
Received: from imladris.infradead.org ([194.205.184.45]:20234 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317230AbSEXSAW>; Fri, 24 May 2002 14:00:22 -0400
Date: Fri, 24 May 2002 19:00:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@tech9.net>
Cc: Marcus Meissner <mm@ns.caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.2.19 with -O3 flag
Message-ID: <20020524190012.A25406@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@tech9.net>, Marcus Meissner <mm@ns.caldera.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205241645.g4OGjbE30934@ns.caldera.de> <1022259244.2638.243.camel@sinai> <20020524184402.A24780@infradead.org> <1022262920.956.258.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 10:55:20AM -0700, Robert Love wrote:
> I know this...maybe I am not being clear.  I realize -Os is a derivate
> of -O2, but is it not an interesting note if -Os can be as fast (or
> faster) than -O2 and still generate smaller binaries?  That is my point.

I've seen it beeing faster with gcc 2.95.  Alan's point was (and I think
the explanation is plausible) is that it is faster exactly _because_ it
produces smaller code due to the instruction cache behaviour of many
current CPUs.

