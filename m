Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTEMMLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbTEMMLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:11:34 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:4870 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263650AbTEMMLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:11:33 -0400
To: zhangtao <zhangtao@zhangtao.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       LinuxKernel MailList <linux-kernel@vger.kernel.org>
Subject: Re: About NLS Codepage 932
References: <20030512100534.1ba6ecd6.zhangtao@zhangtao.org>
	<1052737621.31246.7.camel@dhcp22.swansea.linux.org.uk>
	<20030513101740.626a06a5.zhangtao@zhangtao.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 13 May 2003 21:23:18 +0900
In-Reply-To: <20030513101740.626a06a5.zhangtao@zhangtao.org>
Message-ID: <87d6int4qx.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI,

zhangtao <zhangtao@zhangtao.org> writes:

> The big different is the area of Char To Unicode, the lead byte is :
>   0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9
> 
> In the Microsoft's table (http://www.microsoft.com/globaldev/reference/dbcs/932.htm), they are EMPTY!

These are UDC (User defined charactors).

> But in the Mit edu's CP932.TXT (http://web.mit.edu/afs/dev.mit.edu/source/src-current/third/libiconv/tests/CP932.TXT), they have corresponding letters. 

Looks like using http://www.opengroup.or.jp/jvc/cde/ucs-conv-e.html.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
