Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136923AbREJUxf>; Thu, 10 May 2001 16:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136925AbREJUxZ>; Thu, 10 May 2001 16:53:25 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:37048 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136921AbREJUxI>; Thu, 10 May 2001 16:53:08 -0400
Date: Thu, 10 May 2001 21:52:41 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Mark Hemment <markhe@veritas.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles
Message-ID: <20010510215241.S16590@redhat.com>
In-Reply-To: <20010510211913.R16590@redhat.com> <Pine.LNX.4.21.0105101545140.19732-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105101545140.19732-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, May 10, 2001 at 03:49:05PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 10, 2001 at 03:49:05PM -0300, Marcelo Tosatti wrote:

> Back to the main discussion --- I guess we could make __GFP_FAIL (with
> __GFP_WAIT set :)) allocations actually fail if "try_to_free_pages()" does
> not make any progress (ie returns zero). But maybe thats a bit too
> extreme.

That would seem to be a reasonable interpretation of __GFP_FAIL +
__GFP_WAIT, yes.

--Stephen
