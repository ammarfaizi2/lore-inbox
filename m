Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbTJJO11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbTJJO11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:27:27 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:24270 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262802AbTJJO1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:27:24 -0400
X-Sender-Authentication: net64
Date: Fri, 10 Oct 2003 16:27:22 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: lgb@lgb.hu, Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-Id: <20031010162722.3cd1813f.skraw@ithnet.com>
In-Reply-To: <3F86BD0E.4060607@longlandclan.hopto.org>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>
	<20031009115809.GE8370@vega.digitel2002.hu>
	<20031009165723.43ae9cb5.skraw@ithnet.com>
	<3F864F82.4050509@longlandclan.hopto.org>
	<20031010125137.4080a13b.skraw@ithnet.com>
	<3F86BD0E.4060607@longlandclan.hopto.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Oct 2003 00:07:10 +1000
Stuart Longland <stuartl@longlandclan.hopto.org> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephan von Krawczynski wrote:
> 
> > You are obviously not quite familiar with industrial boxes where this is
> > state-of-the-art. 
>  >
>  > [...]
>  >
> > Generally spoken every part of a computer should be thought of as a
> > "resource" that can be added or removed at any time during runtime. CPU or
> > RAM is in no way different.
>
> Hotplug RAM I could see would be possible, but hotplug CPUs?  I spose if 
> you've got a multiprocessor box, you could swap them one at a time, but 
> my thinking is that this would cause issues with the OS as it wouldn't 
> be expecting the CPU to suddenly disappear.  Problems would be even 
> worse if the old and new CPUs were of different types too.

I wouldn't expect a hotplug feature for differing CPU types actually. But in
fact there are boxes out there that complain via phonecall that a processor
board just died and request replacement. Same goes for RAM. It is obvious that
no feature like this exists on desktop nowadays, but 2.7 and release of 2.8 is
far ahead, so I see no good reason why people should not be enabled to do this
- _then_ .
In fact it is sounds really simple to plug in additional boards to a numa-type
box. Boards meaning RAM+CPU.
HP builds hotplug PCI stuff in comparably cheap boxes, so this is not
completely off-reality.
 
> Hotplug RAM would also be interesting, but then again, I spose the 
> procedure would be to alert the kernel that the memory area from byte X 
> to byte Y would disappear, so it could page that out to swapspace.

This direction sounds likely.

Regards,
Stephan
