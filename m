Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUJOVxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUJOVxt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUJOVwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:52:24 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:15587 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S268505AbUJOVwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:52:00 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       "Kendall Bennett" <KendallB@scitechsoft.com>,
       Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Sat, 16 Oct 2004 05:51:57 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       penguinppc-team@lists.penguinppc.org
References: <416E6ADC.3007.294DF20D@localhost> <416FB624.31033.1D23BE5@localhost>
In-Reply-To: <416FB624.31033.1D23BE5@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410160551.57678.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 October 2004 02:36, Kendall Bennett wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > On 14-10-2004 21:02:36, Kendall Bennett wrote:
>
> How does the framebuffer console system handle secondary controllers
> right now? It seems from my look at the code that it only brings up the
> primary and not the secondary?

By default, the first driver to initialize is used by the fb console.   If
there are more than 1 fb driver, one can either use:

- con2fbmap
- the "fbcon=map:abcd" kernel boot option

Of course, the secondary card must be POSTed.

Tony


