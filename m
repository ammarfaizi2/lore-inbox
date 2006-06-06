Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWFFLzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWFFLzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWFFLzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:55:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50831 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751257AbWFFLzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:55:11 -0400
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: AMD64: 64 bit kernel 32 bit userland - some pending questions
Date: Tue, 6 Jun 2006 13:55:04 +0200
User-Agent: KMail/1.9.3
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       linux-kernel@vger.kernel.org, meissner@suse.de
References: <20060606093456.GL4552@cip.informatik.uni-erlangen.de> <p73lksazht5.fsf@verdi.suse.de> <200606061351.08733.rjw@sisk.pl>
In-Reply-To: <200606061351.08733.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606061355.04334.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 June 2006 13:51, Rafael J. Wysocki wrote:
> On Tuesday 06 June 2006 12:42, Andi Kleen wrote:
> > Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:
> > 
> > > Hello everyone,
> > > I would like to use an AMD64 Opteron System with a 64 bit Linux Kernel,
> > > but a 32 bit userland (Debian Sarge). I have a few questions about this:
> > 
> > The main caveat is that iptables and ipsec need 64bit executables
> > to be set up. The rest should work.
> 
> Recently I've had a problem running wine with a 16-bit windows application
> on a 64-bit kernel.  I guess it's a wine's problem, then?

At some point it worked - i ran 16bit solitaire and some other programs,
but it's not regularly tested.  When it works on a 32bit kernel with
the same wine version it should work on the 64bit kernel too. If not
it's likely a kernel bug.

-Andi
