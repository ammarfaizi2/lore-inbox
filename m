Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268877AbUIMSyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268877AbUIMSyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268870AbUIMSwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:52:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5798 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268864AbUIMSvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:51:23 -0400
Date: Mon, 13 Sep 2004 19:51:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add sparse "__iomem" infrastructure to check PCI address usage
Message-ID: <20040913185120.GD23987@parcelfarce.linux.theplanet.co.uk>
References: <200409110726.i8B7QTGn009468@hera.kernel.org> <4144E93E.5030404@pobox.com> <Pine.LNX.4.58.0409121922450.13491@ppc970.osdl.org> <414508F6.7020301@pobox.com> <Pine.LNX.4.58.0409121945500.13491@ppc970.osdl.org> <20040913183126.GA19399@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913183126.GA19399@thundrix.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 08:31:26PM +0200, Tonnerre wrote:
> Salut,
> 
> On Sun, Sep 12, 2004 at 08:00:48PM -0700, Linus Torvalds wrote:
> > Generally, you shouldn't ever use __force in a driver or anything like 
> > that.
> 
> Why don't we send the __force attribute into some #ifdef that is never
> defined unless  you're in  arch specific code?  This way  we'd prevent
> stupid people from doing stupid things.

man grep
