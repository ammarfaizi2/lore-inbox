Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUAAXdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUAAXdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:33:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:64170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261825AbUAAXc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:32:56 -0500
Date: Thu, 1 Jan 2004 15:33:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-Id: <20040101153303.75d37307.akpm@osdl.org>
In-Reply-To: <20040101151516.236cb610.pj@sgi.com>
References: <20040101043333.186a3268.pj@sgi.com>
	<1072977297.1399.14.camel@nidelv.trondhjem.org>
	<20040101151516.236cb610.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  Right now, compiling a 2.6.0-mm1 (what I had handy) with the 3.3 gcc on
>  my Pentium system for arch i386 generates 1386 signed and unsigned
>  warnings

ugh, that is unacceptable.

Unless anyone has a better idea, yes, we should apply your patch.
