Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVHBOYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVHBOYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVHBOW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:22:59 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:3259 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261554AbVHBOWP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:22:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UIDGMOPY7YAFXV6Ib14MyeQ/e8zDyWSh53Ze088AER4rN8NusrSPw1m5/erW48TqsF+aywXSGL/lnqQJOhQoFkqe406M3v40oICysMgeMuKhI65qLtdwaZRerVcQLy62MHgMZddkQzdUQD57G+mLfxtzlzv38/987jQFzFZInak=
Message-ID: <d120d500050802072256a4d7ee@mail.gmail.com>
Date: Tue, 2 Aug 2005 09:22:12 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: sboyce@blueyonder.co.uk
Subject: Re: Touchpad errors
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42EF633B.6080209@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42EF633B.6080209@blueyonder.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/05, Sid Boyce <sboyce@blueyonder.co.uk> wrote:
> New SuSE 9.3 x86_64 install after HD crash. With 2.6.13-rc3 and up to
> 2.6.13-rc4-git4. I can't remember seeing these errors for quite a long
> time, thought they were fixed, perhaps there is a regression in recent
> kernels.
> It completely and rapidly fills up dmesg and /var/log/messages so I
> can't get other stuff I need to see.
> psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> 

Does it work with acpi=off?

-- 
Dmitry
