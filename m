Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUEWVbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUEWVbL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUEWVbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:31:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8930 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263609AbUEWVbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:31:09 -0400
Message-ID: <40B1180F.8000501@pobox.com>
Date: Sun, 23 May 2004 17:30:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc1
References: <200405231619.i4NGJBe18903@pincoya.inf.utfsm.cl> <40B0EE6C.70400@pobox.com> <20040523211154.GC1833@holomorphy.com>
In-Reply-To: <20040523211154.GC1833@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> I wouldn't qualify either of the major VM patch series merged as
> rewrites. I saw:
> (1) move unmapping function/helpers to different algorithm to save space
> (2) NUMA API and support functions

You missed the pte chains going away, a fundamental change in the way 
reverse mapping is done?

	Jeff


