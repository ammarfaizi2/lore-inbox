Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVEYUfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVEYUfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVEYUfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:35:01 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:13560 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261544AbVEYUe6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:34:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KXYK3K4e3PRka4jxQ0DCk0FV88vEAIn2D1/zRx49mqV6ZaHJhsVz+SVifn0siP5pI7FTYQu4/wQhig0q2kXY0d7QBTGWoMiw9QudyioP6JqqsV18e8UrHif0BDt5skYNbIc6k5jfXxJSk1ut05J4ca/iGazlVy8hUeM9PbvrjBM=
Message-ID: <8783be6605052513343fce843b@mail.gmail.com>
Date: Wed, 25 May 2005 16:34:55 -0400
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Jim Gifford <maillist@jg555.com>
Subject: Re: Random IDE Lock ups with via IDE
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4294BAE8.5050803@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4293B859.3070609@jg555.com> <4294BAE8.5050803@jg555.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's not a bad platter issue.  It could be the electronics on the
drive have a problem, but more  likely something happened like the
drive spun down.  If that is the case, the reset at the end should
have woken it up.  Does the drive work correctly after the reset?

    Ross

On 5/25/05, Jim Gifford <maillist@jg555.com> wrote:
> Tested the hard drive it passes. Any other suggestions
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
