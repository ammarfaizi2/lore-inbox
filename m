Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266305AbUANF3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 00:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUANF3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 00:29:23 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:15831 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266305AbUANF3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 00:29:22 -0500
Date: Wed, 14 Jan 2004 05:27:43 +0000
From: Dave Jones <davej@redhat.com>
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: Paul Symons <PaulS@paradigmgeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: kernel oops 2.4.24
Message-ID: <20040114052743.GD23845@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Craig-Wood <ncw1@axis.demon.co.uk>,
	Paul Symons <PaulS@paradigmgeo.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <798DD0DBF172864C8CC752175CF42BA326C8B2@pat.aberdeen.paradigmgeo.com> <20040113185948.GA17867@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113185948.GA17867@axis.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 06:59:48PM +0000, Nick Craig-Wood wrote:

 > > I am trying to run Gentoo on this hardware, and have had problems from the
 > > start, with respect to compiling things like Gentoo. The hardware is a
 > > little bit of an oddity, because i read that it is classed as i686, yet it
 > > doesn't support the cmov opcode. All my compile optimisations have been at
 > > best i586 as a result.
 > 
 > I wonder if you are thinking of the Nehemiah (the C3 mark 2) rather
 > than the Samuel which is on that board.  As far as I'm aware its only
 > safe to use i386 code and that is what we've been using very
 > succesfully (with a Debian/stable installation).

Samuel (and all other pre-Nehemiah CPUs) can run i586 just fine.
As the original poster said, they're i686 with missing CMOV extension,
which in gcc-speak, is i586.

		Dave

