Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWHBHpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWHBHpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWHBHpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:45:49 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:63948 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751352AbWHBHpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:45:49 -0400
Date: Wed, 2 Aug 2006 09:45:29 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1
Message-ID: <20060802094529.09db5532@cad-250-152.norway.atmel.com>
In-Reply-To: <1154450847.5605.21.camel@localhost>
References: <1154354115351-git-send-email-hskinnemoen@atmel.com>
	<20060731174659.72da734f@cad-250-152.norway.atmel.com>
	<1154371259.13744.4.camel@localhost>
	<20060801101210.0548a382@cad-250-152.norway.atmel.com>
	<1154450847.5605.21.camel@localhost>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006 09:47:27 -0700
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> That 'sec=null' would explain why you are seeing a problem, and the
> attached patch ought to fix it.

That does explain it, but unfortunately the patch doesn't fix it
because data->version is 6. I added "case 6:" on the line after "case
5:", and it solved the problem.

I don't know what the difference between version 5 and 6 is, but I
suspect it has something to do with data->context?

Haavard
