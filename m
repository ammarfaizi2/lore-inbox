Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSDKVPw>; Thu, 11 Apr 2002 17:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312975AbSDKVPv>; Thu, 11 Apr 2002 17:15:51 -0400
Received: from imladris.infradead.org ([194.205.184.45]:59397 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312973AbSDKVPu>; Thu, 11 Apr 2002 17:15:50 -0400
Date: Thu, 11 Apr 2002 22:15:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: the oom killer
Message-ID: <20020411221533.A20867@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020405164348.K32431@dualathlon.random> <Pine.LNX.4.21.0204051844521.11472-100000@freak.distro.conectiva> <20020411151353.K14605@dualathlon.random> <3CB5E6E4.981B8C0D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 12:41:24PM -0700, Andrew Morton wrote:
> It'd be nice if the second and subsequent passes of the oom
> killer were able to note that a kill was already outstanding,
> so they don't just kill the same process all the time.

-rmap uses a simple timeout for that.  And I've just send the
rmap oom_killer tweaks to Marcelo so they hopefully will appear
in mainline soon.

