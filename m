Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUDERIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 13:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbUDERIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 13:08:52 -0400
Received: from p01m170.mxlogic.net ([66.179.109.170]:18601 "HELO
	p01m170.mxlogic.net") by vger.kernel.org with SMTP id S263017AbUDERIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 13:08:49 -0400
Message-ID: <40718B2A.967D9467@amis.com>
Date: Mon, 05 Apr 2004 10:36:58 -0600
From: Eric Whiting <ewhiting@amis.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.5-rc3-mm4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: -mmX 4G patches feedback
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MX-Spam: exempt
X-MX-MAIL-FROM: <ewhiting@amis.com>
X-MX-SOURCE-IP: [207.141.5.253]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm1/announce.txt

>- I've dropped the 4G/4G patch and the remap-file-pages-prot patch.  Two
>  reasons:
>
>  a) They create a lot of noise in areas where Hugh, Andrea and others
>     are working
>
>  b) -mm has been a bit flakey for a few people lately and I suspect the
>     problems are related to early-startup changes in the 4:4 patch.


Andrew -- some data on the 4G/4G problems:

The following kernels with 4G/4G enabled would hang my box about once every 24
hours.
2.6.5-rc2-mm4   
2.6.3-mm3       

The 2.6.5-rc3-mm4 kernel with 4G/4G enabled has been much more stable (like
earlier -mmX kernels with 4G/4G enabled).

The 4G/4G patch is still useful for me -- although 64bit linux (x86_64) is the
best 'real' long-term solution to large memory jobs.  

eric
