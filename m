Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSH0SHt>; Tue, 27 Aug 2002 14:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSH0SHt>; Tue, 27 Aug 2002 14:07:49 -0400
Received: from tapu.f00f.org ([66.60.186.129]:23215 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S316672AbSH0SHs>;
	Tue, 27 Aug 2002 14:07:48 -0400
Date: Tue, 27 Aug 2002 11:12:07 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zheng Jian-Ming <zjm@cis.nctu.edu.tw>,
       linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
Message-ID: <20020827181207.GA8578@tapu.f00f.org>
References: <20020827075426.GA6696@tapu.f00f.org> <Pine.LNX.4.44.0208270940350.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208270940350.3234-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 09:42:27AM -0600, Thunder from the hill wrote:

    I don't think this is cool. I mean, think of how many times we use
    it, who will eat the overhead?

We use it almost never... a few times per process at most.  And the
overhead will be nonexistent except in cases where the caller has to
wait on the lock --- and in those cases it seems totally reasonable
they *should* have to wait.

    Basically everyone. (And BTW, if we can't even afford one lock per
    module, how could we efford one jock per job? There are definitely
    more.)

I'm not sure what you mean here.




  --cw
