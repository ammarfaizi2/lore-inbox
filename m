Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUI1NOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUI1NOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 09:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUI1NOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 09:14:38 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:13572 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267807AbUI1NME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 09:12:04 -0400
In-Reply-To: <1096374908.21271.38.camel@linux.local>
References: <20040928075545.GA3298@cenedra.walrond.org> <200409281524.25187.vda@port.imtp.ilyichevsk.odessa.ua> <1096374908.21271.38.camel@linux.local>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F7151E9B-114F-11D9-A7ED-000D9352858E@linuxmail.org>
Content-Transfer-Encoding: 7bit
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [OT] Microsoft claim 267% better peak performance than linux?
Date: Tue, 28 Sep 2004 15:11:52 +0200
To: Norbert van Nobelen <Norbert@edusupport.nl>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 28, 2004, at 14:35, Norbert van Nobelen wrote:

> The document shows some interesting points though:
> - They describe what they did to make redhat/apache perform better
> - ISAPI is pretty fast compared to CGI (Didn't apache recently release 
> a
> programming interface which is cross platform and does something like
> this too?)

Of course ISAPI is faster than CGI. The same happens with NSAPI. 
However, both are proprietary, have a steep learning curve, and 
usually, xSAPI extensions run on the same address space as the Web 
server, improving performance but decreasing stability. However, CGI 
runs as a separate process which adds a lot of overhead. There are 
solutions like FastCGI with less overhead and that allow persistence 
(the executable CGI is not destroyed, but stays in memory waiting for 
future requests).

MS commissioned studies are totally useless: they only probe what MS 
wants. If MS wants us to believe earth is flat, a MS commissioned study 
will reveal so.

