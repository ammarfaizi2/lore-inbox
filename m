Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWAHAzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWAHAzO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 19:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWAHAzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 19:55:14 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:50922 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161115AbWAHAzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 19:55:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LPWdbLjjqqdlhfzPJ437LU5kQKwfnVIRNvC1IDhchURkRGK/OAeMdB0RUHwef3bY1eyp+CM+SYuBkP6xpVuDsazRnFJWebZaYrrYx8kmyb1teEp44AJtCM5k+nu40iRL625X3LWY3CTxuKrmTc+v1jSWF4U7Wl8eJzLqToKMCQ0=
Message-ID: <43BF1AA1.8000702@gmail.com>
Date: Sat, 07 Jan 2006 09:34:25 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: adaplas@pol.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] drivers/video/imsttfb.c: setclkMHz: clk_p
 is always 0
References: <20060106162554.GJ12131@stusta.de>
In-Reply-To: <20060106162554.GJ12131@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The Coverity checker noticed that in the function setclkMHz in 
> drivers/video/imsttfb.c, the variable clk_p is never assigned a value 
> other than 0.
> 
> Could someone understanding this code decide whether this is a real bug 
> or whether clk_p can be replaced by 0?
> 

It does look like to be an oversight.  The same is present in Xorg code
too.

Tony

