Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbTI2Vhx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTI2Vgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:36:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25991 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262987AbTI2Vgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:36:44 -0400
Message-ID: <3F78A5DE.7010803@pobox.com>
Date: Mon, 29 Sep 2003 17:36:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ULL fixes for qlogicfc
References: <E1A41Rq-0000NJ-00@hardwired> <20030929172329.GD6526@gtf.org> <bla4fg$pbp$1@cesium.transmeta.com> <3F789FE8.6050504@pobox.com> <3F78A2FF.6070203@zytor.com>
In-Reply-To: <3F78A2FF.6070203@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Jeff Garzik wrote:

>>0xffffffff without a prefix is signed.

> No, it's not.
[...]
> ... so 0x7fffffff is signed int, but 0xffffffff is unsigned int on an
> I32-model system (all Linux systems are I32-model.)


I was looking at C99 standard as I typed that :)  But I thought it was 
referring to raw storage size, and that things changed on some 64-bit 
platforms.

So, I stand corrected.

	Jeff



