Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVA3GU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVA3GU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 01:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVA3GU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 01:20:27 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:54349 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261652AbVA3GUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 01:20:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=l2s4bPFdD2JucjveQ7rk/zB0xy7WFpwlCEXknxPCw22pQi/ZBhEyxkif5I/Roz376snXp6H0GPFu0NZXSwD/I+YYKPaIO+iqPiZa6soNCFGq2Vz4OVCo1g5xCsVAROub3DdEGF2G5t+Y2UHqDFEeOYinb3U78fABXVjpbeKlz90=
Message-ID: <891493700501292220216e4186@mail.gmail.com>
Date: Sat, 29 Jan 2005 22:20:24 -0800
From: Andrew Nelson <evildarkarchon@gmail.com>
Reply-To: Andrew Nelson <evildarkarchon@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc2-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050129131134.75dacb41.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050129131134.75dacb41.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a compile error:
arch/x86_64/kernel/asm-offsets.c: In function `main':
arch/x86_64/kernel/asm-offsets.c:65: error: invalid application of
`sizeof' to incomplete type `pbe'
arch/x86_64/kernel/asm-offsets.c:66: error: dereferencing pointer to
incomplete type
arch/x86_64/kernel/asm-offsets.c:67: error: dereferencing pointer to
incomplete type
make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
make: *** [arch/x86_64/kernel/asm-offsets.s] Error 2
