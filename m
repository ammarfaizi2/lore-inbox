Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbRELReW>; Sat, 12 May 2001 13:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbRELReM>; Sat, 12 May 2001 13:34:12 -0400
Received: from m2ep.pp.htv.fi ([212.90.64.98]:21521 "EHLO m2.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S261293AbRELReB>;
	Sat, 12 May 2001 13:34:01 -0400
Message-ID: <3AFD743E.D581B91@tyrell.hu>
Date: Sat, 12 May 2001 20:34:54 +0300
From: Akos Maroy <darkeye@tyrell.hu>
Organization: Tyrell Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Process accessing a Sony DSC-F505V camera through USB as a 
 storage device hangs.
In-Reply-To: <3AFD2E41.213CFB47@tyrell.hu> <20010512151803.C8826@arthur.ubicom.tudelft.nl> <3AFD5C66.1CED33FB@tyrell.hu> <20010512185037.F8826@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> 
> On Sat, May 12, 2001 at 06:53:10PM +0300, Akos Maroy wrote:
> > Erik Mouw wrote:
> > >
> > > On Sat, May 12, 2001 at 03:36:17PM +0300, Akos Maroy wrote:
> > > > [1.] One line summary of the problem:
> > > >
> > > > Process accessing a Sony DSC-F505V camera through USB as a storage
> > > > device hangs.
> >
> > Additional information to this issue: kernel 2.4.3 works fine on the
> > same machine, with the same kernel compilation settings.
> 
> Hmm. Not that I am a USB expert, but could you try it with the usb-uhci
> driver? The uhci driver got quite some changes in 2.4.4, so it might be
> related with those changes.

Good tip, it works with this driver. Which module is is which option in
the kernel configuration? Is it:

CONFIG_USB_UHCI			uhci
CONFIG_USB_UHCI_ALT		usb-uhci

Or the other way around?


Akos
