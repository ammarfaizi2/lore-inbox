Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWAZQk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWAZQk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWAZQk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:40:26 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:58890 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964776AbWAZQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:40:25 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Hai Zaar <haizaar@gmail.com>
Subject: Re: vesa fb is slow on 2.6.15.1
Date: Thu, 26 Jan 2006 16:40:19 +0000
User-Agent: KMail/1.9
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com> <43D8E1EE.3040302@gmail.com> <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>
In-Reply-To: <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601261640.19570.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 January 2006 16:06, Hai Zaar wrote:
> On 1/26/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > mtrr now defaults to off in vesafb because of conflicts with xorg/
> > xfree86.  You have to explicitly enable it with a boot option.  Try
> > this:
> >
> > video=vesafb:mtrr:3,ypan
> >
> > Tony
>
> I've replaced 'vga=795' with 'video=vesafb:mtrr:3,ypan' and rebooted.
> Now framebuffer is not activated at all - I get plain old 80x25
> console. Are you sure that old vesafb (not vesafb-tng) driver
> understands 'video=...' parameters style?

Do not replace vga= and it will work fine. See Documentation/fb/vesafb.txt.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
