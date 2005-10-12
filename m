Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVJLI5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVJLI5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 04:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVJLI5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 04:57:15 -0400
Received: from c3po.0xdef.net ([217.172.181.57]:60554 "EHLO c3po.0xdef.net")
	by vger.kernel.org with ESMTP id S932403AbVJLI5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 04:57:15 -0400
Date: Wed, 12 Oct 2005 10:57:14 +0200
From: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Instantiating my own random number generator
Message-ID: <20051012085713.GA24974@0xdef.net>
Mail-Followup-To: Hagen Paul Pfeifer <hpplinuxml@0xdef.net>,
	linux-kernel@vger.kernel.org
References: <E90C20D8-AC5D-4E9E-A477-48164FA0E7EE@inf.ufrgs.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E90C20D8-AC5D-4E9E-A477-48164FA0E7EE@inf.ufrgs.br>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.11 Roberto Jung Drebes pressed the following keys:

>Is there a way I can set this number generator my own seed value, so  
>that I can replay experiments I perform with my module? If I set a  
>seed for the whole system, it would affect other kernel tasks  
>obtaining random numbers through get_random_bytes(), so I guess that  
>is not a good solution.

No, there insn't a direct alternative. get_random_bytes() should be
good enough - do you realize a weak spot?

>TIA,

HGN

