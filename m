Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268821AbTGIXtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268807AbTGIXsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:48:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39048 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268732AbTGIXmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:42:33 -0400
Message-ID: <3F0CABCD.6020608@pobox.com>
Date: Wed, 09 Jul 2003 19:57:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.22-pre3: P3 and P4 for chekc_gcc
References: <20030709223355.GA2604@werewolf.able.es> <3F0C9EE8.2050005@pobox.com> <20030709230754.GA18564@werewolf.able.es>
In-Reply-To: <20030709230754.GA18564@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> Just curious, what can go wrong ? Only if gcc has a bug when scheduling
> insns for P4, for example, or if gcc spits some special that does not
> work as supposed...


Well, any number of things, but I admit it's mostly just general 
paranoia / conservatism on my part.

In the past, on rare occasions, modification of the global CFLAGS or use 
of new gcc features has led to silent miscompilation of a few drivers.

	Jeff



