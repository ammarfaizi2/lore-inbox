Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312322AbSDCSWh>; Wed, 3 Apr 2002 13:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312323AbSDCSW1>; Wed, 3 Apr 2002 13:22:27 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:3599 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S312322AbSDCSWQ>; Wed, 3 Apr 2002 13:22:16 -0500
Subject: Re: [PATCH] 2.4.19pre2 radeonfb
From: Tommy Faasen <faasen@xs4all.nl>
To: Peter Horton <pdh@berserk.demon.co.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020402230043.GA4330@berserk.demon.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 03 Apr 2002 20:29:21 +0200
Message-Id: <1017858562.413.0.camel@it0>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-03 at 01:00, Peter Horton wrote:
> A small patch that fixes some issues with the Radeon frame buffer driver.
> 
> 1) Pulled updated soft reset code from XFree86 (stopped my VE hanging the
> machine when acceleration was enabled).
> 
> 2) Added MTRR for frame buffer region.
> 
> 3) Fixed a couple of buglets in the acceleration code. The driver now
> enables acceleration by default (acceleration support for 8bpp mode
> only).
> 
> P.
Does this only have an effect on the framebuffer stuff or also on
xfree86?
I for example don't use the framebuffer but I was wondering if this
would solve some bugs?

