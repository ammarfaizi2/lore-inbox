Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTJTN6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 09:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTJTN6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 09:58:03 -0400
Received: from mail.g-housing.de ([62.75.136.201]:58084 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262441AbTJTN6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 09:58:01 -0400
Message-ID: <3F93E9E6.2050106@g-house.de>
Date: Mon, 20 Oct 2003 15:57:58 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: de-de, de, en-gb, en-us, en
MIME-Version: 1.0
To: Chris Anderson <chris@simoniac.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Module problems with NVIDIA and 2.6.0-test8?
References: <Pine.LNX.4.43.0310201410410.27849-100000@cibs9.sns.it> <1066655152.26573.0.camel@kuso>
In-Reply-To: <1066655152.26573.0.camel@kuso>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Anderson schrieb:
> On Mon, 2003-10-20 at 08:11, venom@sns.it wrote:
> 
>>which version of nvidia driver are you using.
>>1.0-3123 works just fine with test8.
> 
> 
> 4496, sorry (can't believe I forgot to mention this). Perhaps I'll try
> one of the older drivers when I get home.

4496 works fine here with 2.6.0-test8. i had some issues with the GLX 
support, but re-installing the user-space part of the nvidia module has 
solved it. be sure to compile the module against the *right* 
kernel-includes.

Christian.

-- 
BOFH excuse #285:

Telecommunications is upgrading.

