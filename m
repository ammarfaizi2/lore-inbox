Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbWHNTay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWHNTay (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWHNTay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:30:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:34287 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932679AbWHNTax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:30:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N5u8X64xwKXeI5qAblTNB+yB+Rxz/orS4KdwEy2Rxn+K2AwoZAgvUo2swxr9gMKXw0IcGKeURzs5Kx/xqW9/bBTyf8zafcBg4+CzpFSyAYP9CcVHKJrTt2y5hrlSx6Lo+rX7TUQAdcndpMe7k+5E+CijEqtbJsqxTpcfDyIf8ZE=
Message-ID: <d120d5000608141230x2b03abe3uff2d310fe37a9ddc@mail.gmail.com>
Date: Mon, 14 Aug 2006 15:30:51 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Subject: Re: Touchpad problems with latest kernels
Cc: "Gene Heskett" <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000608140841q657c6c2euae986b37f6aff605@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
	 <200608141038.04746.gene.heskett@verizon.net>
	 <20060814152000.GA19065@rhlx01.fht-esslingen.de>
	 <d120d5000608140841q657c6c2euae986b37f6aff605@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 8/14/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> >
> > (without a mouse plugged in) after random times the pointer exhibits
> > clear signs of craziness, moving on its own (mild issue) or jumping
> > uncontrollably (worse) or being completely off-screen most of the time
> > (worst).
> >

BTW, next time it gets stuck could you please do:

echo 1 > /sys/modules/i8042/parameters/debug

and if cursor is still stuck (or otherwise misbehaving) after that
send me your dmesg or /valog/log/kernel.

Thanks!

-- 
Dmitry
