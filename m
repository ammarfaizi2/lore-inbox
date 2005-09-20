Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVITXXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVITXXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 19:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVITXXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 19:23:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28065 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750717AbVITXXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 19:23:41 -0400
Date: Tue, 20 Sep 2005 19:23:18 -0400
From: Dave Jones <davej@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Charles McCreary <mccreary@crmeng.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
Message-ID: <20050920232318.GC1040@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
	Charles McCreary <mccreary@crmeng.com>,
	linux-kernel@vger.kernel.org
References: <200509201212.55676.mccreary@crmeng.com> <Pine.LNX.4.58.0509201028050.2553@g5.osdl.org> <20050920194446.GA15606@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920194446.GA15606@taniwha.stupidest.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 12:44:46PM -0700, Chris Wedgwood wrote:
 > On Tue, Sep 20, 2005 at 10:30:48AM -0700, Linus Torvalds wrote:
 > 
 > > This is quite possibly the result of an Opteron errata (tlb flush
 > > filtering is broken on SMP) that we worked around as of 2.6.14-rc4.
 > 
 > It would be really interesting to know if this does help.  I was told
 > em64t also have the 'bad pmd' problem but I can't make it happen here
 > on opteron on em64t.

In the dozens of reports of bad pmd that Fedora users filed, there
wasn't a single EM64T user.  In fact, most of the hits were from
very similar product lines, from a handful of vendors (Tyan's seemed
especially susceptable). It may be that other vendors updated their
BIOS's to include this workaround already, and Tyan and a few others
lagged behind.

		Dave

