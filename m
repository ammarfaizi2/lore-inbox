Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVIZHcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVIZHcY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 03:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVIZHcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 03:32:24 -0400
Received: from web8405.mail.in.yahoo.com ([202.43.219.153]:7568 "HELO
	web8405.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932424AbVIZHcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 03:32:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sfxMPVQjfByONKjf5Juq9XE4e4geghimXcJfd7M6Zxtwk+OpnGfDKrr0x7PvgFpRlyFw45hTG7lXciY+eWsIc4T5bJxZGYWm8Gtpfkr+LdnnsrmWnrZ5LFm6uishBKVXMnpAA0VxYIBoaDxbu52M8oiLIhlyZOzdiozziI/WW3g=  ;
Message-ID: <20050926073220.55509.qmail@web8405.mail.in.yahoo.com>
Date: Mon, 26 Sep 2005 08:32:20 +0100 (BST)
From: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: Re: AIO Support and related package information??
To: =?iso-8859-1?q?S=E9bastien=20Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <1127459153.2103.3.camel@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi Sebastien ,

I am having yet another query related to AIO Support

1)As you mentioned that aio posix support is provided
by glibc also so can you tell me on the performance
basis which one is better (glibc implementation or
libposix implementation ) and how do we measure the
performance

I have compiled glibc with following command 

gcc -g $1.c -o $1 -lrt -lpthread 


2)What posix features is supported by bare kernel and
libposix implementation, without applying the
patches.I have broken down my  query in following
parts

2.1) aio_read/aio_write  is supported but what
limitation are there

2.2) aio_fsync is supported or not

2.3) what are the limitation with lio_listio

2.4) what are the additional feature it provides for
aio_cancel implementation


3) Is glibc implementation is providing all the above
mentioned fetures

4) Is there any test program that can measure
efficiency for both glibc and libposix implementation


With Thanks in advance 
Vikas 



		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
