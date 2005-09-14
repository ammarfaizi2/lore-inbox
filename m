Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVINPuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVINPuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbVINPuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:50:21 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:58269 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030203AbVINPuT (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 14 Sep 2005 11:50:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ffesYhxdM/4r5db9MZG8xi8HWHjQtXnlYlH+GXWliM8k2Ck2JypQik1RkoSzNVwQI3wqVamirNy1zWTQWIh94D9BsjeKjfqB260SStIn41CdHhyLE3J7X6wUb8bMk61zT2AWfler73wKDJWAj/RPishSCzPwI2SiG1rIfv1kdJ0=  ;
Message-ID: <43283FC9.9080106@yahoo.com.au>
Date: Thu, 15 Sep 2005 01:20:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
CC: Dipankar Sarma <dipankar@in.ibm.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4/5] atomic: dec_and_lock use cmpxchg
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <432838E8.5030302@yahoo.com.au> <432839F1.5020907@yahoo.com.au>
In-Reply-To: <432839F1.5020907@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Index: linux-2.6/kernel/rcupdate.c
> ===================================================================
> --- linux-2.6.orig/kernel/rcupdate.c
> +++ linux-2.6/kernel/rcupdate.c

Dang, this leaked in from 3/5, and 1/5 also has some funny
whitespace I introduced.

They'll all still apply just fine, and the end result will
look the same, so they're fine for testing and comments.
I'll submit cleaned up and signed off versions if/when we're
ready (speaking of which, David I should get you to sign
this as well if you agree with it)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
