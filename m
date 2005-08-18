Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVHRXG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVHRXG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 19:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHRXG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 19:06:57 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:64423 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932311AbVHRXG4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 19:06:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ft7/HMrLjsJAqKBye0RMaHsd/XfM1jB4I5juMD7Bvy6PZaxY6QSAbmwJ8cE0gj4yLCyJFF6Y25qCDQ0UtJ8kDNXxHAGRLqmle1eKt28mvd0kQco/uQkmUxVHz6Jq7D0mCEvNGdVHzDDAHbtHinLwt69L+VXARXnto2mzITmF4eo=
Message-ID: <9a87484905081816066365aebf@mail.gmail.com>
Date: Fri, 19 Aug 2005 01:06:52 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: [PATCH] rename locking functions - fix a blunder in initial patches
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050819090235.D4075975@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508182309.35274.jesper.juhl@gmail.com>
	 <20050819090235.D4075975@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/05, Nathan Scott <nathans@sgi.com> wrote:
> On Thu, Aug 18, 2005 at 11:09:33PM +0200, Jesper Juhl wrote:
> > ...
> > have if getting rid of the defines is prefered, then that's something that
> > can easily be done later.
> 
> I tend to agree with Christoph on this - this level of internal API
> churn is unnecessary and can be error prone (as you cunningly showed ;)
> - please just leave it as is, and move on to greener pastures.
> 

If that's the general oppinion, then sure, I'll leave it alone. Just
thought it would be nice to make things more consistently named.

I'll leave it in the capable hands of akpm and not press the issue any further.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
