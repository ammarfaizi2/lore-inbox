Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTDPNmK (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTDPNmK 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:42:10 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:23195 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S264373AbTDPNmI 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 09:42:08 -0400
Date: Wed, 16 Apr 2003 15:53:50 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Lukasz Trabinski <lukasz@wsisiz.edu.pl>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre7 - aic79xx
In-Reply-To: <Pine.LNX.4.50.0304160856110.16588-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0304161543100.22459-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003, Zwane Mwaikambo wrote:

> On Wed, 16 Apr 2003, Geller Sandor wrote:
>
> > On Wed, 16 Apr 2003, Lukasz Trabinski wrote:
> >
> > > In article <Pine.LNX.4.53.0304161212390.5122@oceanic.wsisiz.edu.pl> you wrote:
> > > > Hello
> > > >
> > > > I have new machine with aic79xx scsi controler,
> > >
> > > exactly is Adaptec AIC7902 Ultra320
> >
> > Try the latest aic7xxx drivers:
> > http://people.FreeBSD.org/~gibbs/linux/SRC/
>
> This is by no means a solution or even a workaround, but could you tell me
> what happens if you boot with noapic?

I don't use the aic79xx driver in the -ac tree. In another thread, 1 or 2
weeks ago Justin Gibbs stated, that his latest drivers are the most
stable. I'm using an Intel 7501VW2 motherboard in a production server, so
I don't want to test drivers, which can cause filesystem corruption. Maybe
Lukasz can test with noapic - I suggest Justin's drivers, and if the
problem still exists, test with the 'noapic' boot parameter, and track
down the problem. Regards,

  Sandor Geller <wildy@petra.hos.u-szeged.hu>

