Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbSJURA4>; Mon, 21 Oct 2002 13:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261499AbSJURA4>; Mon, 21 Oct 2002 13:00:56 -0400
Received: from quark.didntduck.org ([216.43.55.190]:11016 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S261390AbSJURA4>; Mon, 21 Oct 2002 13:00:56 -0400
Message-ID: <3DB4341F.20109@didntduck.org>
Date: Mon, 21 Oct 2002 13:06:39 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
References: <F2DBA543B89AD51184B600508B68D4000E6AE154@fmsmsx103.fm.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:
> I think it depends on the assumptions for the compiler quality. If you don't
> trust __attribute__ ((align(xxx)), many other things are broken as well. Why
> do you need to check this particular one, especially?

Because the hardware requires it.

--
				Brain Gerst

