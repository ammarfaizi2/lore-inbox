Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbUKJV1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUKJV1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUKJV0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:26:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19329 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262134AbUKJVYi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:24:38 -0500
Message-ID: <41928705.3020707@pobox.com>
Date: Wed, 10 Nov 2004 16:24:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniele Venzano <webvenza@libero.it>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] WOL for sis900
References: <4183B6B0.7010906@gmx.de> <1100055532.25963.58.camel@localhost.localdomain> <20041110204054.GA29083@picchio.gall.it>
In-Reply-To: <20041110204054.GA29083@picchio.gall.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Venzano wrote:
> What I'm really lacking is some piece of technical documentation for the
> chip. The WoL support depends on this, because I don't know how to check
> for the hardware support for it.

The sis900 hardware is based on the NatSemi register layout:
http://gkernel.sourceforge.net/specs/national_semi/DP83815.pdf.bz2

