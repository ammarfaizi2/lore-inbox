Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUCBTyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 14:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUCBTyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 14:54:40 -0500
Received: from hera.kernel.org ([63.209.29.2]:13470 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261746AbUCBTyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 14:54:38 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
Date: Tue, 2 Mar 2004 19:54:28 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c22opk$hq1$1@terminus.zytor.com>
References: <1078254284.2232.385.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078257268 18242 63.209.29.3 (2 Mar 2004 19:54:28 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 2 Mar 2004 19:54:28 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1078254284.2232.385.camel@cube>
By author:    Albert Cahalan <albert@users.sourceforge.net>
In newsgroup: linux.dev.kernel
>
> > As RBJ said, ptys are now recycled in pid-like fashion,
> > which means numbers won't be reused until wraparound
> > happens.  This is good for security/fault tolerance,
> > at least to some minor degree.
> 
> Ouch. It's bad for display and bad for typing.
> What is easier to type?
> 
> ps -t pts/6
> ps -t pts/1014962
> 
> (and yes, I really type these -- I don't have a
> third hand to operate the mouse simultaneously)
> 

(Programmable) tab completion, anyone?

	-hpa
