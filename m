Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUJOAad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUJOAad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUJOAad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 20:30:33 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:14265 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267324AbUJOA27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 20:28:59 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       "Kendall Bennett" <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 08:27:38 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net,
       penguinppc-team@lists.penguinppc.org
References: <416E6ADC.3007.294DF20D@localhost>
In-Reply-To: <416E6ADC.3007.294DF20D@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410150827.38943.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 October 2004 03:02, Kendall Bennett wrote:
> So what we would like to find out is how much interest there might be in
> both an updated VESA framebuffer console driver as well as the code for
> the Video card BOOT process being contributed to the maintstream kernel.
> If there is interest, we would start out by first contributing the core
> emulator and Video BOOT code, and then work on building a better VESA
> framebuffer console driver.
>
> So what do you guys think?
>

I'm for it, if you can get the code in the kernel.  If not, what are the 
arguments against doing this in userspace?

If you remember about 2 years ago, there was a thread which you started
about vesafbd.  From that, I've worked on vm86d which is a generic approach
to running BIOS code in user space. I stopped development on this though,
but it should be easy to revive. There is also vesafb-tng. I think it runs
BIOS code in kernel space.

The video BOOT code is also nice, especially for non-primary graphics cards.

Tony


