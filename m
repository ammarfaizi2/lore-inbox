Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274244AbRJEWQC>; Fri, 5 Oct 2001 18:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274248AbRJEWPw>; Fri, 5 Oct 2001 18:15:52 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:7894 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S274244AbRJEWPo>;
	Fri, 5 Oct 2001 18:15:44 -0400
Date: Sat, 6 Oct 2001 00:16:11 +0200 (CEST)
From: Seth Mos <knuffie@xs4all.nl>
To: David Schwartz <davids@webmaster.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <20011005220627.AAA22897@shell.webmaster.com@whenever>
Message-ID: <Pine.BSI.4.10.10110060011450.303-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, David Schwartz wrote:

> 
> >The system is beafy enough to tolerate something mundane as this. It should
> >definitely not die.
> 
> 	A fork bomb with no limits attempts to create an infinite number of 
> processes. No system can be that beefy.

I was refering to the mundane load of mongo.pl with 5 processes. Something
the systems should withstand. If you have more then 10GB of database to
access you would want it to work. I am not talking about a lot of
processes but a lot of disk IO.

I have just one box running SMP with highmem and that one is acting
funny. All the other SMP ur Uni servers have absolutely no
problems.

Disable highmem and the problem goes away while halving your ram. That is
not very efficient is it?

Cheers


