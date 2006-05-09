Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWEIUQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWEIUQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWEIUQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:16:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23999 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751119AbWEIUQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:16:19 -0400
Date: Tue, 9 May 2006 16:14:50 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       masouds@masoud.ir, jeff@garzik.org, gregkh@suse.de
Subject: Re: [PATCH] VIA quirk fixup, additional PCI IDs
Message-ID: <20060509201450.GK15257@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org, masouds@masoud.ir, jeff@garzik.org,
	gregkh@suse.de
References: <20060430162820.GA18666@masoud.ir> <20060509191455.GA27503@taniwha.stupidest.org> <20060509125916.03c96efe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509125916.03c96efe.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:59:16PM -0700, Andrew Morton wrote:
 > Chris Wedgwood <cw@f00f.org> wrote:
 > >
 > > An earlier commit (75cf7456dd87335f574dcd53c4ae616a2ad71a11) changed
 > > an overly-zealous PCI quirk to only poke those VIA devices that need
 > > it.  However, some PCI devices were not included in what I hope is now
 > > the full list.
 > > 
 > > This should I hope correct this.
 > > 
 > > Thanks to Masoud Sharbiani <masouds@masoud.ir> for pointing this out
 > > and testing the fix.
 > 
 > This looks like a 2.6.17-worthy fix, but it's not clear.  Help.  What
 > happens if 2.6.17 doesn't have this??

We won't run the quirk on machines that used to have it run,
so we get buggered up irq routing.

		Dave

-- 
http://www.codemonkey.org.uk
