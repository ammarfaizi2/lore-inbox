Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272653AbTG3Ctw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 22:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272658AbTG3Ctw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 22:49:52 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:12239 "HELO
	develer.com") by vger.kernel.org with SMTP id S272653AbTG3Ctv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 22:49:51 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Date: Wed, 30 Jul 2003 04:49:37 +0200
User-Agent: KMail/1.5.9
Cc: Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200307232046.46990.bernie@develer.com> <200307242227.16439.bernie@develer.com> <20030729222921.GK16051@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030729222921.GK16051@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307300449.37692.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 July 2003 00:29, Tom Rini wrote:

> > Some of the bigger 2.6 additions cannot be configured out.
> > I wish sysfs and the different I/O schedulers could be removed.
> >
> > There are probably many other things mostly useless for embedded
> > systems that I'm not aware of.
>
> Well, from Pat's talk at OLS, it seems like sysfs would be an important
> part of 'sleep', which is something at least some embedded systems care
> about.

I tried stripping sysfs away. I just saved 7KB and got a kernel that
couldn't boot because root device translation depends on sysfs ;-)

> ... not that 2.6 doesn't need some good pruning options now, but maybe
> CONFIG_EMBEDDED isn't the right place to put them all.

In the long term the embedded menu would get cluttered with all kinds
of disparate options... I don't think I would like it.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


