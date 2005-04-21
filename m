Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVDUC3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDUC3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 22:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVDUC3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 22:29:09 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:55480 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261181AbVDUC3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 22:29:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Wed, 20 Apr 2005 21:29:03 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200503201557.58055.pmcfarland@downeast.net> <200504202112.14969.dtor_core@ameritech.net> <200504202221.57718.pmcfarland@downeast.net>
In-Reply-To: <200504202221.57718.pmcfarland@downeast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504202129.04083.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 April 2005 21:21, Patrick McFarland wrote:
> On Wednesday 20 April 2005 10:12 pm, Dmitry Torokhov wrote:
> > On Wednesday 20 April 2005 20:42, Patrick McFarland wrote:
> > > On Wednesday 20 April 2005 12:47 am, Patrick McFarland wrote:
> > > > I just tested 2.6.6, it seems to be broken too. I wonder if this
> > > > actually is a kernel issue, I should have found a working kernel by
> > > > now. I'll continue to 2.6.5.
> > >
> > > I just tried 2.6.5 and 2.6.4. No go. Only 3 kernels left.
> >
> > Are you testing with sidewinder?
> 
> I test both my analog and sidewinders. Not that it matters, my analog is the 
> one I had first, I only got the sidewinder recently.
> 

Ok... I know that sidewinder needs its timeouts increased to about 6ms to
work with 2.6. Have you tried OSS driver - to make sure that layer above
the soundcard works?

-- 
Dmitry
