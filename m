Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274972AbTHRUgb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274969AbTHRUgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:36:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:2029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274972AbTHRUcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:32:45 -0400
Date: Mon, 18 Aug 2003 13:32:01 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [ALPHA] Update for "name" out of struct device.
Message-ID: <20030818203200.GA3067@kroah.com>
References: <200308181611.h7IGBEcW024487@hera.kernel.org> <20030818164512.GF24693@gtf.org> <20030818165109.GG24693@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818165109.GG24693@gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 12:51:09PM -0400, Jeff Garzik wrote:
> On Mon, Aug 18, 2003 at 12:45:12PM -0400, Jeff Garzik wrote:
> > What do you think about the following patch?  It follows the style of
> > other PCI core messages, and prints out the same information as before.
> 
> ...except for the pretty name, of course.
> 
> But IMO we need to stop drivers and core from printing out pretty-name
> at all, which is another reason for my patch.  Having name information
> like this in the kernel, overall, is a waste, IMO.  _Especially_ when
> that information is conditional.  We should be consistent with what we
> print out, to reduce user confusion.

Hence "pci_name()"  :)

greg k-h
