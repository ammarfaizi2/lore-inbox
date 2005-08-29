Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVH2Xe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVH2Xe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVH2Xe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:34:26 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:10395 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932068AbVH2XeZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:34:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jozaVgLRQ279Mt1VerXG/gC466N7XAxOycGUoTa5Kh8M+ytUaVI5KHVXMtgqfhxDdlBzWrmR8pS+KOOquf5P+88aqHScmvgoKQomprUhOvVaGyMQuF8zRCjTUT9JmCW3sf1wfBv0uUGchXxjpDhYR2RJ1DkCHSGrteuu//4Uw6E=
Message-ID: <9a8748490508291634416a18bc@mail.gmail.com>
Date: Tue, 30 Aug 2005 01:34:25 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Diego Calleja <diegocg@gmail.com>
Subject: Re: Linux-2.6.13 : __check_region is deprecated
Cc: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050830012813.7737f6f6.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050829231417.GB2736@localhost.localdomain>
	 <20050830012813.7737f6f6.diegocg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Diego Calleja <diegocg@gmail.com> wrote:
[snip]
> 
> /me wonders why check_region has not been killed, it has been
> deprecated for years; killing it would force developers to fix it
> and would help to identify unmaintained drivers...

I don't see why we should break a bunch of drivers by doing that.
Much better, in my oppinion, to fix the few remaining drivers still
using check_region and *then* kill it. Even unmaintained drivers may
still be useful to a lot of people, no point in just breaking them for
the hell of it.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
