Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUD1MlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUD1MlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 08:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264765AbUD1MlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 08:41:17 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:30643 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264770AbUD1MlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 08:41:11 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
Date: Wed, 28 Apr 2004 07:41:08 -0500
User-Agent: KMail/1.6.1
Cc: Erik Steffl <steffl@bigfoot.com>
References: <40853060.2060508@bigfoot.com> <200404281022.23878.kim@holviala.com> <408F697D.2010906@bigfoot.com>
In-Reply-To: <408F697D.2010906@bigfoot.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404280741.08665.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I may chime in...

On Wednesday 28 April 2004 03:21 am, Erik Steffl wrote:
 
> input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
> input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
> input: PS2++ Logitech Mouse on isa0060/serio1
> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> input: PS2++ Logitech Mouse on isa0060/serio1
> input: PS/2 Generic Mouse on isa0060/serio1
> input: PS/2 Generic Mouse on isa0060/serio1
> input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
> 

So your mouse pretty much can work with any protocol... Now could you please
re-load the module without any parameters and post the output of
"cat /proc/bus/input/devices"

Also compile evbug module, insert it in the kernel (with psmouse loaded as
well), hit all buttons again and post the excerpt of dmesg with evbug data.
I want to make sure that your button is not identified correctly as opposed
to some data lost in protocol transformation.

What protocol are you using in XFree?

-- 
Dmitry
