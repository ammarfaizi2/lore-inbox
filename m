Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSH0T4z>; Tue, 27 Aug 2002 15:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSH0T4y>; Tue, 27 Aug 2002 15:56:54 -0400
Received: from tapu.f00f.org ([66.60.186.129]:39859 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S317066AbSH0T4v>;
	Tue, 27 Aug 2002 15:56:51 -0400
Date: Tue, 27 Aug 2002 13:01:10 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thunder from the hill <thunder@lightweight.ods.org>,
       Zheng Jian-Ming <zjm@cis.nctu.edu.tw>, linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
Message-ID: <20020827200110.GB8985@tapu.f00f.org>
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm> <1030382219.1751.14.camel@irongate.swansea.linux.org.uk> <20020827075426.GA6696@tapu.f00f.org> <shsvg5wqemp.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shsvg5wqemp.fsf@charged.uio.no>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 09:35:10PM +0200, Trond Myklebust wrote:

    Locking does absolutely nothing for the problem of checking file
    access with one set of credentials, and then doing the subsequent file
    operation with another set of credentials.

Can we not lock creds at the syscall level? Ick... shoot me for saying
this :)



  --cw
