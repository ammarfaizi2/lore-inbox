Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVJSD6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVJSD6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 23:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVJSD6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 23:58:14 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:35709 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932457AbVJSD6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 23:58:14 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-rc4-mm1
Date: Tue, 18 Oct 2005 22:58:10 -0500
User-Agent: KMail/1.8.2
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <20051016154108.25735ee3.akpm@osdl.org> <4354B1D1.4060802@ens-lyon.org> <20051019034447.GB15940@kroah.com>
In-Reply-To: <20051019034447.GB15940@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510182258.10919.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 22:44, Greg KH wrote:
> On Tue, Oct 18, 2005 at 10:26:57AM +0200, Brice Goglin wrote:
> > Le 18.10.2005 09:40, Greg KH a ?crit :
> > > If you disable CONFIG_PNP, does the oops go away?
> > > 
> > > Also, does this oops keep you from booting?  If not, can you see what
> > > the output of 'cat /proc/bus/input/devices' produces (it should show
> > > what device is dying on us.)
> > 
> > Yes disabling CONFIG_PNP makes it disappear.
> 
> Odd.  Dmitry, any ideas?
>

Not yet, except that PC speaker is one of input devices that does not have
a parent struct device...
 
-- 
Dmitry
