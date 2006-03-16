Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752212AbWCPV2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbWCPV2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbWCPV2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:28:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54236 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752194AbWCPV2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:28:43 -0500
Date: Thu, 16 Mar 2006 16:27:26 -0500
From: Alan Cox <alan@redhat.com>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Alan Cox <alan@redhat.com>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, v4l-dvb-maintainer@linuxtv.org,
       mdharm-usb@one-eyed-alien.net
Subject: Re: [usb-storage] Re: [v4l-dvb-maintainer] 2.6.16-rc: saa7134 + u sb-storage = freeze
Message-ID: <20060316212726.GD9697@devserv.devel.redhat.com>
References: <820212CF2FD63647B52A8F64B35352B20B942298@essomaexc1.essvote.com> <20060315234421.GB4414@devserv.devel.redhat.com> <1142538911.4666.69.camel@praia>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1142538911.4666.69.camel@praia>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 04:55:11PM -0300, Mauro Carvalho Chehab wrote:
> Em Qua, 2006-03-15 às 18:44 -0500, Alan Cox escreveu:
> > On Wed, Mar 15, 2006 at 03:24:40PM -0600, Ballentine, Casey wrote:
> > > I would bet we could add the vt8235 to the list of broken chipsets 
> > > as well, if it's not already there.  My company has completely 
> > 
> > "Works for me" 8)
> On overlay mode? Weird!

May depend on the northbridge not the south, or the combination of course

VIA just posted some BIOS updates. If we can get the before and after we
can probably figure it out. If not then once the new BIOSes go from beta 
it'll be a case of poking via gently for info
