Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbUDFPHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUDFPGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:06:17 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:32179 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263850AbUDFPGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:06:09 -0400
Date: Tue, 6 Apr 2004 16:03:33 +0100
From: Dave Jones <davej@redhat.com>
To: Jan Killius <jkillius@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with cpufreq on 2.6.5-mm1
Message-ID: <20040406150333.GD6930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Killius <jkillius@arcor.de>, linux-kernel@vger.kernel.org
References: <20040406101609.GA25248@gate.unimatrix> <20040406135441.GC32405@redhat.com> <200404061653.14606.jkillius@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404061653.14606.jkillius@arcor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 04:53:14PM +0200, Jan Killius wrote:

 > >  > The patch have fixed the problem. thx
 > >
 > > Can you try out the fully merged patch at
 > > http://www.codemonkey.org.uk/projects/bitkeeper/cpufreq
 > > too please ?
 >
 > the patch don't apply clean to 2.6.5-mm1.

No, it's against 2.6.5 vanilla. You'll get it to apply to -mm
if you backout (patch -R) the bk-cpufreq.patch  first from
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm1/broken-out/

		Dave

