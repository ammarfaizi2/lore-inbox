Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVHSDeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVHSDeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVHSDeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:34:19 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:53392 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751107AbVHSDeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:34:19 -0400
Subject: Re: [PATCH] Mobil Pentium 4 HT and the NMI
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org
In-Reply-To: <20050818202300.254410f4.akpm@osdl.org>
References: <1124416748.5186.94.camel@localhost.localdomain>
	 <20050818202300.254410f4.akpm@osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 18 Aug 2005 23:34:10 -0400
Message-Id: <1124422450.5186.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 20:23 -0700, Andrew Morton wrote:
> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Hi,
> > 
> > I'm resending this since I don't see it in git yet, and I'm wondering if
> > there is a problem with this patch.  I have a IBM ThinkPad G41 with a
> > Mobile Pentium 4 HT.  Without this patch, the NMI won't be setup.  Is
> > there a reason that if the x86_model is greater than 0x3 it will return.
> > Since my processor has a 0x4 x86_model, I upped it to that. Otherwise my
> > laptop won't be able to use the NMI.
> > 
> 
> Well I was hoping that someone with knowledge of the low-level Intel model
> differences would pipe up, but they all seem to be in hiding.  (Wildly
> bcc's lots of x86 people).
> 

If this is any consolation, I've been using this patch all day today
debugging a deadlock in Ingo's RT patch.  It seems to work fine with me.

Who knows, maybe in two days my Laptop will be dead because this set up
some self destruct register. (knocks on wood).

-- Steve


