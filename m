Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbSJ2ToZ>; Tue, 29 Oct 2002 14:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbSJ2ToZ>; Tue, 29 Oct 2002 14:44:25 -0500
Received: from mtao-m02.ehs.aol.com ([64.12.52.8]:3204 "EHLO
	mtao-m02.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S262243AbSJ2TnF>; Tue, 29 Oct 2002 14:43:05 -0500
Date: Tue, 29 Oct 2002 11:49:25 -0800
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-reply-to: <20021028220809.GB27798@outpost.ds9a.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Message-id: <3DBEE645.3020808@netscape.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b)
 Gecko/20021016
References: <20021028220809.GB27798@outpost.ds9a.nl>
 <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com>
 <20021028225821.GA29868@outpost.ds9a.nl> <3DBDCC02.6060100@netscape.com>
 <20021029001843.GB31212@outpost.ds9a.nl>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

>That is a semantics change and not an API/ABI change.
>
An API/ABI encompasses the semantics of the calls.  A change to the 
semantics is a change to the API/ABI.  

>I bet Davide knows best.
>
Nope, he doesn't.

>An easy solution is to have sys_epoll_ctl check if there is there is data
>ready and make sure there is an edge to report in that case to the next call
>of sys_epoll_ctl().
>  
>
This is the very solution I am proposing.


