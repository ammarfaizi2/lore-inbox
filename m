Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUALWvk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUALWvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:51:40 -0500
Received: from [66.35.79.110] ([66.35.79.110]:58544 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261190AbUALWvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:51:35 -0500
Date: Mon, 12 Jan 2004 14:50:23 -0800
From: Tim Hockin <thockin@hockin.org>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: raven@themaw.net, Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Message-ID: <20040112225023.GA21399@hockin.org>
References: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au> <40029C19.409@sun.com> <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net> <4002CAB6.3000800@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4002CAB6.3000800@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 11:26:30AM -0500, Mike Waychison wrote:
> /usr   /man1   server:/usr/man1   \
>          /man2   server:/usr/man2
> 
> is the same as the two distinct entries:
> 
> /usr/man1   server:/usr/man1
> /usr/man2   server:/usr/man2
> 
> Now that I think about it, the discussion in my proposal paper about 
> multimounts with no root offsets probably isn't required.

The latter requires /usr/man1 and /usr/man2 to exist.  The former only
requires /usr to exist, right?

