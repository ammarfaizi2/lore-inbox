Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbVHSLRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbVHSLRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 07:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVHSLRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 07:17:37 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:52796 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932629AbVHSLRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 07:17:36 -0400
X-ME-UUID: 20050819111735730.B26641C003F1@mwinf0303.wanadoo.fr
Date: Fri, 19 Aug 2005 13:21:15 +0200
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, torvalds@osdl.org
Subject: Re: [PATCH] Mobil Pentium 4 HT and the NMI
Message-ID: <20050819112115.GA710@zaniah>
References: <1124416748.5186.94.camel@localhost.localdomain> <20050818202300.254410f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818202300.254410f4.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005 at 20:23 +0000, Andrew Morton wrote:

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

There is no documented change regarding to the used msr for P4 model 4,
Zwane do this for oprofile the 2005-02-02 and nobody complained.

-- 
Philippe Elie

