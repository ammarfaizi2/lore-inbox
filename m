Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVJJIGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVJJIGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 04:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVJJIGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 04:06:34 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:64773 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750705AbVJJIGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 04:06:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SrptgatCTn9MxQMcH3TM6n3G/5p6w80WT7VU5Du8ST9rSRI1Tm1i3Z6E94pd/46XAwaFrcLYQvd29SqhnzOje3q7PbI02VS8w7Bj6i3/8T4seg2sg73G4wG9o4KH5FQ/O/A31GQYrWDxFmKwSLG/So9sKunxWaaLUAdSlkxUCTY=
Message-ID: <434A20FD.10600@gmail.com>
Date: Mon, 10 Oct 2005 16:06:21 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: Manuel Lauss <mano@roarinelk.homelinux.net>, linux-kernel@vger.kernel.org
Subject: Re: Modular i810fb broken, partial fix
References: <200510071547.14616.bero@arklinux.org> <4347C39F.2020703@pol.net> <4347E611.9040705@roarinelk.homelinux.net> <200510091848.19345.bero@arklinux.org>
In-Reply-To: <200510091848.19345.bero@arklinux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
> On Saturday, 8. October 2005 17:30, Manuel Lauss wrote:
>> for reference:
>> modprobe i810fb mode_option=1024x768-8@60 hsync1=40 hsync2=60 vsync1=50
>> vsync2=70 vram=4
> 
> Can you try with 1024x768-16@60? That's what we're using in the installer (and 
> what people reported to gable the display).
> 

Try disabling I2C/DDC support of i810fb.  A messed-up EDID block can
give problems with the display.

Tony

