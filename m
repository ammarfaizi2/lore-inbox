Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbTJ3PUB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 10:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTJ3PUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 10:20:01 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:30857 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262581AbTJ3PT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 10:19:57 -0500
Date: Thu, 30 Oct 2003 15:19:12 +0000
From: Dave Jones <davej@redhat.com>
To: Holger Schurig <h.schurig@mn-logistik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Post-halloween doc updates.
Message-ID: <20031030151912.GB11311@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Holger Schurig <h.schurig@mn-logistik.de>,
	linux-kernel@vger.kernel.org
References: <20031030141519.GA10700@redhat.com> <bnr9ud$rjq$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnr9ud$rjq$2@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 30, 2003 at 04:15:25PM +0100, Holger Schurig wrote:
 > > - Blank screen after decompressing kernel?
 > >   Make sure your .config has
 > >    CONFIG_INPUT=y
 > >    CONFIG_VT=y
 > >    CONFIG_VGA_CONSOLE=y
 > >    CONFIG_VT_CONSOLE=y
 > >   A lot of people have discovered that taking their .config from 2.4 and
 > >   running make oldconfig to pick up new options leads to problems, notably
 > >   with CONFIG_VT not being set.
 > 
 > Would a couple of "default y" entries in Kconfig be a cure against this?

Reports of this problem seem to have tailed off over the last few months
so its entirely possible that this is now fixed.

		Dave
