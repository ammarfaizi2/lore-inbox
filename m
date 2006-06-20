Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWFTIR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWFTIR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWFTIR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:17:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32165 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965148AbWFTIRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:17:55 -0400
Subject: Re: E1000 zero copy
From: Arjan van de Ven <arjan@infradead.org>
To: Heng Du <debbiehow315@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <7fc623d50606192355l799ea043hc4eacb190e6be1ce@mail.gmail.com>
References: <7fc623d50606192355l799ea043hc4eacb190e6be1ce@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 10:17:52 +0200
Message-Id: <1150791472.2891.164.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 14:55 +0800, Heng Du wrote:
> Hi all,
> 
> I want to know if there is an existing patch to e1000 network driver
> to enable zero copy.
> If so, can you share me with it?
> If not, is it accepable if I submit a patch?
> Many thanks

Hi,

The e1000 driver supports zero copy for sending already for a long time
(if I remember correctly, since 2.4.3 kernel or so) already. Zero copy
receive is a much harder issue, and for that you need more
infrastructure; I think the IOAT patches that got merged last night in
the post-2.6.17 tree will help for that, but I do not know if what got
merged is sufficient already for full support. 
I hope this answers your question; if not I would like to ask you to
explain in more detail what you mean by "enable zero copy"...

Greetings,
   Arjan van de Ven

