Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265989AbUA1SER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUA1SEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:04:16 -0500
Received: from terminus.zytor.com ([63.209.29.3]:55019 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265989AbUA1SEO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:04:14 -0500
Message-ID: <4017F991.2090604@zytor.com>
Date: Wed, 28 Jan 2004 10:04:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: klibc list <klibc@zytor.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: long long on 32-bit machines
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Does anyone happen to know if there are *any* 32-bit architectures (on 
which Linux runs) for which the ABI for a "long long" is different from 
passing two "longs" in the appropriate order, i.e. (hi,lo) for bigendian 
or (lo,hi) for littleendian?

I'd like to switch klibc to use the 64-bit file ABI thoughout, but it's 
a considerable porting effort, and I'm trying to figure out how to best 
manage it.

	-hpa
