Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWEEUxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWEEUxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWEEUxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:53:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:25747 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751774AbWEEUxh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:53:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TZ+Iuf6LJ8t2FYOGTYy9MM7J08GXTDaI7dyyBn7bj7aRRZHpY475dtRkrnIimeAvm/Bqz9uKWyGjZi2BUTCHWE1vEwKhOmsv1xK1CKCH3Vyxz/K1CSf35dFlJ/E+Gr5A7ojeoSQKlLqHp26Uo7TznRELT0CbkRfpWDrtZHCwZOs=
Message-ID: <c0c067900605051353k53e74fdeo5caed2b9621091d5@mail.gmail.com>
Date: Fri, 5 May 2006 16:53:36 -0400
From: "Dan Merillat" <harik.attar@gmail.com>
To: "Martin Schwidefsky" <schwidefsky@googlemail.com>
Subject: Re: Kbuild + Cross compiling
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6e0cfd1d0605050736g624c2a6fm68ab8b659fa6e253@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com>
	 <6e0cfd1d0605050736g624c2a6fm68ab8b659fa6e253@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/06, Martin Schwidefsky <schwidefsky@googlemail.com> wrote:
> On 5/5/06, Dan Merillat <harik.attar@gmail.com> wrote:
> > I must be an idiot, but why does Kbuild rebuild every file when cross-compiling?
> > I'm not editing .config or touching any headers, I'm making tweaks to
> > a single .c driver,
> > and it is taking forever due to continual full-rebuilds.
>
> I had that problem a while ago. Turned out that the version of make I used on
> my debian had a bug.

That was it.  debian make 3.80 was buggy.   Since make was a likely
culprit I upgraded it anyway, then I read this and it confirmed what I
found.

Thanks for the help, everyone.
