Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268682AbTBZI1V>; Wed, 26 Feb 2003 03:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268683AbTBZI1V>; Wed, 26 Feb 2003 03:27:21 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:42505 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S268682AbTBZI1U>; Wed, 26 Feb 2003 03:27:20 -0500
Date: Wed, 26 Feb 2003 19:33:18 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Christoph Hellwig <hch@infradead.org>
cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
       <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>, <kuznet@ms2.inr.ac.ru>, <pekkas@netcore.fi>,
       <usagi@linux-ipv6.org>
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
In-Reply-To: <20030225160634.A4525@infradead.org>
Message-ID: <Pine.LNX.4.44.0302261926450.13739-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, Christoph Hellwig wrote:

> Also I really wonder whether we want to add just md5.c to 2.4 or
> backport the cryptoapi core with md5 as the only algorithm so far..

Any backport of new cryptoapi is likely to be some way off (after 2.6
stabilizes), so the md5 module submitted for 2.4 is required for the time
being.


- James
-- 
James Morris
<jmorris@intercode.com.au>


