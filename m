Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263797AbUDPVAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUDPU66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:58:58 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:20126 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263754AbUDPU6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:58:32 -0400
Date: Fri, 16 Apr 2004 21:57:37 +0100
From: Dave Jones <davej@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to make stack executable on demand?
Message-ID: <20040416205737.GD25240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, "H. J. Lu" <hjl@lucon.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <20040416170915.GA20260@lucon.org> <1082145778.9600.6.camel@laptop.fenrus.com> <20040416204651.GA24194@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416204651.GA24194@lucon.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 01:46:51PM -0700, H. J. Lu wrote:
 > On Fri, Apr 16, 2004 at 10:02:58PM +0200, Arjan van de Ven wrote:
 > > >  But it will either fail if
 > > > kernel is set with non-executable stack,
 > > 
 > > eh no. mprotect with prot_exec is still supposed to work. The stacks
 > > still have MAY_EXEC attribute, just not the actual EXEC attribute
 > 
 > Ok. It looks like a bug in Red Hat EL 3 kernel. In fs/exec.c, there

That version of exec-shield is quite dated. For the latest version,
look on http://people.redhat.com/mingo, or the Fedora kernels.

I'm pretty sure that Exec-shield isn't even enabled in the EL kernels
at this time, so it's quite out of date in respect to the others.

		Dave

