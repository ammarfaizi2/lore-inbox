Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUDPF3d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUDPF3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:29:33 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:36245
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S262347AbUDPF3K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:29:10 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Phil Oester <kernel@linuxace.com>
Cc: Andrew Morton <akpm@osdl.org>, shannon@widomaker.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040416045924.GA4870@linuxace.com>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1082093346.7141.159.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 22:29:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 15/04/2004 klokka 21:59, skreiv Phil Oester:

> If simply upgrading from 2.4.x to 2.6.x is going to make UDP mounts unusable,
> perhaps this should be documented -- or the option should be deprecated.

Put simply: I am not interested in wasting _my_ time investigating cases
where UDP is performing badly if TCP is working fine. The variable
reliability issues with UDP are precisely why we worked to get the TCP
stuff working efficiently.

As for blanket statements like the above: I have seen no evidence yet
that they are any more warranted in 2.6.x than they were in 2.4.x. At
least not as long as I continue to see wire speed performance on reads
and writes on UDP on all my own test setups.

Cheers,
  Trond
