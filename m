Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbRELRrQ>; Sat, 12 May 2001 13:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbRELRrF>; Sat, 12 May 2001 13:47:05 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:34322 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261306AbRELRqs>; Sat, 12 May 2001 13:46:48 -0400
Date: Sat, 12 May 2001 19:46:27 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Akos Maroy <darkeye@tyrell.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Process accessing a Sony DSC-F505V camera through USB as a storage device hangs.
Message-ID: <20010512194627.G8826@arthur.ubicom.tudelft.nl>
In-Reply-To: <3AFD2E41.213CFB47@tyrell.hu> <20010512151803.C8826@arthur.ubicom.tudelft.nl> <3AFD5C66.1CED33FB@tyrell.hu> <20010512185037.F8826@arthur.ubicom.tudelft.nl> <3AFD743E.D581B91@tyrell.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFD743E.D581B91@tyrell.hu>; from darkeye@tyrell.hu on Sat, May 12, 2001 at 08:34:54PM +0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2001 at 08:34:54PM +0300, Akos Maroy wrote:
> Erik Mouw wrote:
> > Hmm. Not that I am a USB expert, but could you try it with the usb-uhci
> > driver? The uhci driver got quite some changes in 2.4.4, so it might be
> > related with those changes.
> 
> Good tip, it works with this driver. Which module is is which option in
> the kernel configuration? Is it:
> 
> CONFIG_USB_UHCI			uhci
> CONFIG_USB_UHCI_ALT		usb-uhci
> 
> Or the other way around?

It's the other way around.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
