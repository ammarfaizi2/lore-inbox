Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVGYQgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVGYQgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 12:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVGYQgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 12:36:36 -0400
Received: from quark.didntduck.org ([69.55.226.66]:35503 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261364AbVGYQge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 12:36:34 -0400
Message-ID: <42E51593.7070902@didntduck.org>
Date: Mon, 25 Jul 2005 12:38:43 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6-0.1.fc5 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question re the dot releases such as 2.6.12.3
References: <200507251020.08894.gene.heskett@verizon.net>
In-Reply-To: <200507251020.08894.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Greetings;
> 
> I just built what I thought was 2.6.12.3, but my script got a tummy 
> ache because I didn't check the Makefile's EXTRA_VERSION, which was 
> set to .2 in the .2 patch.  Now my 2.6.12 modules will need a refresh 
> build. :(
> 
> So whats the proper patching sequence to build a 2.6.12.3?
> 

The dot-release patches are not incremental.  You apply each one to the 
base 2.6.12 tree.

--
				Brian Gerst
