Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284366AbRLMQ1K>; Thu, 13 Dec 2001 11:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284370AbRLMQ1B>; Thu, 13 Dec 2001 11:27:01 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:60846 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S284366AbRLMQ0v>;
	Thu, 13 Dec 2001 11:26:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: passing params to boot readonly
Date: Thu, 13 Dec 2001 08:26:48 -0800
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C1841BB.8010003@neuron.com> <E16EPYW-0003nW-00@phalynx> <3C1874D5.5050205@namesys.com>
In-Reply-To: <3C1874D5.5050205@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16EYh6-0004At-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 13, 2001 01:28, Hans Reiser wrote:
> >It'd probably be pretty easy to make a boot disk using a hacked version of
> >ReiserFS that refuses to replay the journal, by adding a "return 0;" near
> > the top of journal_read(struct super_block *) in journal.c. However, you
> > might feel more comfortable sending it off for data recovery than testing
> > kernel hacks on it ;)

> why not just edit the source code directly and recompile?

Just curious, but how would editing the source and recompiling be any 
different from what I suggested?

-Ryan
