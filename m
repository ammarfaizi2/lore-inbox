Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272729AbTHEMkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272686AbTHEMiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:38:15 -0400
Received: from proibm3.procempa.com.br ([200.248.222.108]:8083 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S272726AbTHEMhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:37:54 -0400
Date: Tue, 5 Aug 2003 09:40:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <green@namesys.com>
Subject: Re: decoded problem in 2.4.22-pre10
In-Reply-To: <20030805100040.079b1b24.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0308050919150.20461-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Aug 2003, Stephan von Krawczynski wrote:

> Hello all,
> 
> the testbox crashed again this night, unfortunately I made a mistake yesterday
> and started vmware once. Although only the usual modules were loaded at crash
> time and not the application, the kernel was tainted of course.
> Nevertheless I present the data:
> 
> Everthing started with this it seems:
> 
> journal-2332: Trying to log block 4316, which is a log block
>  (device sd(8,17))
> 
> Then:

Hello Stephan,

Mind trying to reproduce the problem without the vmware modules?

I think they might be the problem here.

