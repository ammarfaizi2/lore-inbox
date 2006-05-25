Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWEYLnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWEYLnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 07:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWEYLnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 07:43:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:3790 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965117AbWEYLnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 07:43:07 -0400
Date: Thu, 25 May 2006 13:42:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Olivier Galibert <galibert@pobox.com>
cc: Ivan Novick <ivan@0x4849.net>, Nuri Jawad <lkml@jawad.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       julian@valgrind.org
Subject: Re: Linux Kernel Source Compression
In-Reply-To: <20060523142302.GA45392@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.61.0605251341400.28358@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222015.01980.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr> <200605222200.18351.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.64.0605230407320.25860@pc> <1148393727.14381.262121289@webmail.messagingengine.com>
 <20060523142302.GA45392@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> just wanted to remark that I never liked that bzip was replaced by bzip2 
>> (were there license issues?) since bzip's compression was/is often 
>> stronger:
>
>bzip1 uses arithmetic encoding which is heavily patented.  bzip2 uses
>huffman instead, which isn't, but is slightly (10% is often quoted)
>less efficient.  I guess bzip3 could use range coding which is
>supposedly patent-free[1] and has similar compression ratio than
>arithmetic coding.
>
Although plans for a bzip3 have been posted (I think removing the MTF and 
so on...), it has not been done yet. Maybe I am wrong here.


Jan Engelhardt
-- 
