Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264205AbUE0NWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264205AbUE0NWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUE0NWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:22:21 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:65217 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264368AbUE0NVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:21:44 -0400
Date: Thu, 27 May 2004 14:19:59 +0100
From: Dave Jones <davej@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Vincent Lefevre <vincent@vinc17.org>
Subject: Re: [2.4.26] overcommit_memory documentation clarification
Message-ID: <20040527131959.GA15337@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
	Vincent Lefevre <vincent@vinc17.org>
References: <20040509001045.GA23263@ay.vinc17.org> <20040509214941.GG7161@ay.vinc17.org> <20040527122042.GC13095@logos.cnet> <200405271430.11125@WOLK> <20040527130925.GA13520@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527130925.GA13520@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 10:09:25AM -0300, Marcelo Tosatti wrote:

 > > > We should or merge Alan's strict-overcommit patches (from RH's tree),
 > > > or fix the documentation.
 > > I vote for the strict-overcommit thing. Do you have that handy for your 
 > > 2.4-bk?
 > > Alan, prolly you? Or do we have to extract it from 
 > > linux-2.4.21-selected-ac-bits.patch? ;)
 > 
 > Alan is busy with other things.
 > The strict overcommit fixes need to be extraced and tested.
 > Dave Jones told me about it the other day.
 > Still haven't found the time to download RH's srpm.

The overcommit bits in the Fedora SRPM come directly from the
2.4.22-ac1 patch.  You're better off just grabbing  Bero's -pac patch.
He has a 2.4.26 patch, which should save you rediffing,
just chop out the relevant bits.

http://kernel.org/pub/linux/kernel/people/bero/2.4/2.4.27/

		Dave

