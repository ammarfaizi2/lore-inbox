Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275375AbTHGOxY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275376AbTHGOxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:53:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27575 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275375AbTHGOwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:52:08 -0400
Message-ID: <3F32678B.7020407@pobox.com>
Date: Thu, 07 Aug 2003 10:51:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Javier Achirica <achirica@telefonica.net>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] airo driver: fix races, oops, etc..
References: <Pine.SOL.4.30.0308070946380.22832-100000@tudela.mad.ttd.net>
In-Reply-To: <Pine.SOL.4.30.0308070946380.22832-100000@tudela.mad.ttd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Achirica wrote:
> I've been studying the problem for a while and I've implemented a solution
> using a single kernel thread and a wait queue for synchronization. I've
> tested it and looks like it works fine. It can be used both in 2.4
> and 2.6 kernels. Before submitting a patch with it I'd like someone with
> experience in this kind of code to take a look at it just in case I'm
> doing something dumb. Jeff? :-)


Unless the patch is huge (100K or more), post it to linux-kernel, and CC 
it to me and Benjamin Herrenschmidt.

	Jeff



