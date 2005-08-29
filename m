Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVH2X73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVH2X73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVH2X73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:59:29 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:47468 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932088AbVH2X72 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:59:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bDXKXFfGvAUxc9IZRRYOAlJMOYm7H+3NniJc0xPEjrCpD/rLqxJDcBZO1R0uRjVOMwylZhowgzFSY+z2fqSUCde3ezELzaL7bRDlN0IhRm4APyqrDQMMwjjUsp6yQU2Ir3dlQoJ6B7WdYUJpWQH4PgUwKRdizCcHCwgvLiHP7Mc=
Message-ID: <9a874849050829165920d687a3@mail.gmail.com>
Date: Tue, 30 Aug 2005 01:59:27 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Diego Calleja <diegocg@gmail.com>
Subject: Re: Linux-2.6.13 : __check_region is deprecated
Cc: stephane.wirtel@belgacom.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050830015513.62ee2c0c.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050829231417.GB2736@localhost.localdomain>
	 <20050830012813.7737f6f6.diegocg@gmail.com>
	 <9a8748490508291634416a18bc@mail.gmail.com>
	 <20050830015513.62ee2c0c.diegocg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Diego Calleja <diegocg@gmail.com> wrote:
> El Tue, 30 Aug 2005 01:34:25 +0200,
> Jesper Juhl <jesper.juhl@gmail.com> escribió:
> 
> > I don't see why we should break a bunch of drivers by doing that.
> > Much better, in my oppinion, to fix the few remaining drivers still
> > using check_region and *then* kill it. Even unmaintained drivers may
> 
> I'd usually agree with you, but check_region has been deprecated for so many
> time; I was just wondering myself if people will bother to fix the remaining
> drivers without some "incentive"
> 
I fixed a few a while back, without any incentive other than "this
just needs to be done".
I'm sure noone would object if you submitted a few patches yourself to
fix some of the remaining ones.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
