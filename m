Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270094AbTGXUMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270097AbTGXUMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 16:12:16 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:11234 "HELO
	develer.com") by vger.kernel.org with SMTP id S270094AbTGXUMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 16:12:15 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Date: Thu, 24 Jul 2003 22:27:16 +0200
User-Agent: KMail/1.5.9
Cc: Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200307232046.46990.bernie@develer.com> <200307240007.15377.bernie@develer.com> <20030723222747.GF643@alpha.home.local>
In-Reply-To: <20030723222747.GF643@alpha.home.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307242227.16439.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 July 2003 00:27, Willy Tarreau wrote:

> On Thu, Jul 24, 2003 at 12:07:15AM +0200, Bernardo Innocenti wrote:
> >    text    data     bss     dec     hex filename
> >  633028   37952  134260  805240   c4978 linux-2.4.x/linux-Os
> >  819276   52460   78896  950632   e8168 linux-2.5.x/vmlinux-inline-Os
> >  ^^^^^^
> >        2.6 still needs a hard diet... :-/
>
> I did the same observation a few weeks ago on 2.5.74/gcc-2.95.3. I tried
> to track down the responsible, to the point that I completely disabled
> every driver, networking option and file-system, just to see, and got about
> a 550 kB vmlinux compiled with -Os. 550 kB for nothing :-(

Some of the bigger 2.6 additions cannot be configured out.
I wish sysfs and the different I/O schedulers could be removed.

There are probably many other things mostly useless for embedded
systems that I'm not aware of.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


