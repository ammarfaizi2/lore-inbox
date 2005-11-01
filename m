Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVKAP2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVKAP2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVKAP2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:28:07 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:8234 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750888AbVKAP2G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:28:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sz1W3Yp4b6SY05K7ZiRwgQgzxxkx7zNTmI7YM71IciaXYU32C/sav5/0Sz/bhBUWgPxaNEuxWZr8KrNjC6Iz4K0INweQXBfFN9khI8jBVS7uB2/+FmDnX4a5KdRni1RNtSAX1bRzzyyizvuqLsA9LpNiQsU5OnMiIs+NdFKLr0A=
Message-ID: <d120d5000511010728o79303ebcw2a4e3c2c3c201a1b@mail.gmail.com>
Date: Tue, 1 Nov 2005 10:28:04 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Kernel Badness 2.6.14-Git
Cc: Robert Love <rml@novell.com>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43678814.80407@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4362BFF1.3040304@linuxwireless.org>
	 <200510312221.13217.dtor_core@ameritech.net>
	 <20051101073530.GB27536@kroah.com>
	 <200511010258.14313.dtor_core@ameritech.net>
	 <20051101081433.GB28048@kroah.com>
	 <1130854317.16163.52.camel@phantasy> <43678814.80407@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Bill Davidsen <davidsen@tmr.com> wrote:
>
> What about serio? Can that be used too early as well? Serial console?

Serio seems to be in the right place for now but if pulling input.o to
the top works well I think I'll do the same with serio.

--
Dmitry
