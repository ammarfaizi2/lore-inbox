Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTGAKOK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTGAKOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:14:10 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:13958 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261960AbTGAKOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:14:08 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Johoho <johoho@hojo-net.de>, Wiktor Wodecki <wodecki@gmx.de>
Subject: Re: [PATCH] O1int 0307010922 for 2.5.73 interactivity
Date: Tue, 1 Jul 2003 20:32:00 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200307010944.46971.kernel@kolivas.org> <200307010952.26595.kernel@kolivas.org> <20030701101238.GB686@gmx.de>
In-Reply-To: <20030701101238.GB686@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307012032.00913.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003 20:12, Wiktor Wodecki wrote:
> Hello,
>
> On Tue, Jul 01, 2003 at 09:52:26AM +1000, Con Kolivas wrote:
> > On Tue, 1 Jul 2003 09:44, Con Kolivas wrote:
> > > Here is an evolution of the O1int design to minimise audio skips/smooth
> > > X. I've been forced to work with even less sleep than usual because of
> > > this but I'm getting quite happy with it now.
>
> for normale usage I'm happy with it, even under heavy load (two kernel
> compiles with -j4 on a single processor machine) I can type into my
> xterms mostly instantly.
> However starting new applications/xterm's is a pain, a plain xterm which
> starts normally within a second takes about 3-5secs. Openoffice isn't
> usable at all. But on the other side I normally don't compile with
> -j4...
> However the xmms didn't skip once while playing. I applied this patch
> ontop of 2.5.73-bk7.

At least we're moving in the right direction; last time you tried it was a 
disaster on your machine. Tuning can help this sort of thing. Before I tweak 
it further to tackle this can you tell me exactly which version you used? 
Sorry it's such a moving target.

Con

