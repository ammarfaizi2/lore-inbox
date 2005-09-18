Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVIRGGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVIRGGU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 02:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVIRGGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 02:06:20 -0400
Received: from mail.stdbev.com ([63.161.72.3]:60093 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S1751135AbVIRGGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 02:06:19 -0400
Message-ID: <0bb8a8210bf8b3b9b02fbb8625deb58e@stdbev.com>
Date: Sun, 18 Sep 2005 01:06:18 -0500
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: snd-usb-audio modpost warnings
To: <linux-kernel@vger.kernel.org>
Cc: <mroos@linux.ee>, <adobriyan@gmail.com>
Reply-to: <jason@stdbev.com>
In-Reply-To: <9b589152e27635af5f737b30db0fc812@stdbev.com>
References: <Pine.SOC.4.61.0509161002560.22187@math.ut.ee>
            <20050917103614.GA6956@mipter.zuzino.mipt.ru>
            <9b589152e27635af5f737b30db0fc812@stdbev.com>
X-Mailer: Hastymail 1.5-CVS
x-priority: 3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9:51:44 pm 09/17/05 "Jason Munro" <jason@stdbev.com> wrote:
> On 5:36:14 am 09/17/05 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >  On Fri, Sep 16, 2005 at 10:04:51AM +0300, Meelis Roos wrote:
> > >   FYI: todays git snapshot gives these warnings:
> >
> >  -git3?
> >
> > >     MODPOST
> > >   *** Warning: "__compound_literal.200" [sound/usb/snd-usb-audio.ko]
> > >   undefined!
> >
> >  Please, send .config
>
> Similar results here except with 2.6.14-rc4-mm1. The warnings for
> snd-usb-audio are new, the ones for the xircom-tulip-cb are not. Full
> output of make modules_install attached with .config.

Interestingly downgrading the Debian unstable gcc packages from 4.0.1-7 to
4.0.1-6 fixes the undefined warning problems with snd-usb-audio. Debian
package bug?

\__  Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/

