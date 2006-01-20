Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWATNN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWATNN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 08:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWATNN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 08:13:57 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:14521 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750943AbWATNN4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 08:13:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q1dyci0YGbQxMoR4TRRQjQvPTrLbrWJqvFm5inuuH+lx4cTplEUYsx8FR/t/slUK56M6GNVpwpRT1zZrrDq6JvnhuK7GFEmHPz5xh0/m3Usn3bzePUq9S0tHw6RmksxIedtlKslZJLBLau3xAMpljhPVuhLFV7LiijzRnv5Mhq0=
Message-ID: <84144f020601200513r60b206fbx3137d3fe74829c45@mail.gmail.com>
Date: Fri, 20 Jan 2006 15:13:54 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: So - What's going on with Reiser 4?
Cc: Lee Revell <rlrevell@joe-job.com>, marc@perkel.com, arjan@infradead.org,
       mail@earthworm.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060120040023.310a1ea8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43C837B6.5070903@perkel.com>
	 <1137236892.3014.12.camel@laptopd505.fenrus.org>
	 <200601141322.34520.mail@earthworm.de>
	 <1137242691.3014.16.camel@laptopd505.fenrus.org>
	 <43C99491.3080907@perkel.com> <1137293454.19972.6.camel@mindpipe>
	 <43C9C042.5090000@perkel.com> <1137299139.25801.7.camel@mindpipe>
	 <20060120040023.310a1ea8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 1/20/06, Andrew Morton <akpm@osdl.org> wrote:
> Well it is a bit.  Current status is that we just don't have anyone who's
> sufficiently familar with VFS internals and idioms who has the
> time+inclination to sit down and work with the reiserfs developers to get
> the thing into a generally-acceptable state.  Progress has been made over
> the past 12-28 months, but there's more to do.  It's a huge piece of code
> and a lot of work to do this.

Has there been discussion on what's acceptable state? More
specifically, is fs/reiser4/page_cache.c and fs/reiser4/lock.c bits
going to be merged or are they expected to be merged with generic
code? What about the plugin bits?

                               Pekka
