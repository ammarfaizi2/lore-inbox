Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWAZWEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWAZWEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWAZWEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:04:07 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:36816 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964913AbWAZWEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:04:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BEHM+vQMMj3It4G3Q495Jgb3IdPTjgjoeOKacqItADKRnqurnYO1wyteLmxi/ggH+Wgb/xY0aADiNVGci3up/zi+M+2kEGAWFNIYcCQHmUHoitlo5K4PFU4CbeX+2Hyv0H+UbLVnYZhmuCJt4RdsHZpMtYS+6ui3Fu5hYql/vxo=
Message-ID: <43D94764.3040303@gmail.com>
Date: Fri, 27 Jan 2006 06:04:20 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Hai Zaar <haizaar@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: vesa fb is slow on 2.6.15.1
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>	 <43D8E1EE.3040302@gmail.com> <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>
In-Reply-To: <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai Zaar wrote:
> On 1/26/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> I've replaced 'vga=795' with 'video=vesafb:mtrr:3,ypan' and rebooted.
> Now framebuffer is not activated at all - I get plain old 80x25
> console. Are you sure that old vesafb (not vesafb-tng) driver
> understands 'video=...' parameters style?
> 

You need both vga= and video=vesafb

Tony
