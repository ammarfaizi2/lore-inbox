Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTIGMKp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 08:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTIGMKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 08:10:45 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:7381
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262994AbTIGMKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 08:10:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.0-test4-mm5 and below: Wine and XMMS problems
Date: Sun, 7 Sep 2003 22:18:27 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20030902231812.03fae13f.akpm@osdl.org> <20030907100843.GM14436@fs.tum.de>
In-Reply-To: <20030907100843.GM14436@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309072218.28116.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Sep 2003 20:08, Adrian Bunk wrote:
> On Tue, Sep 02, 2003 at 11:18:12PM -0700, Andrew Morton wrote:
> >...
> > . Dropped out Con's CPU scheduler work, added Nick's.  This is to help us
> >   in evaluating the stability, efficacy and relative performance of
> > Nick's work.
> >
> >   We're looking for feedback on the subjective behaviour and on the usual
> >   server benchmarks please.
> >...
>
> Short story:
>
> I'm still using 2.5.72, all of the 2.6.0-test?{,-mm?} kernels have
> problems

What's your X and xmms nice values? Many X servers are reniced to -10 and some 
shells spawn new apps at nice 5. After that the most common thing I find in 
reports are upgrades to newer kernels losing hard disk dma at some stage (due 
to config changes/movements) and it not being noticed.

Con

