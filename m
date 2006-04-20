Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWDTL3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWDTL3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 07:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWDTL3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 07:29:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:19908 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750803AbWDTL3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 07:29:54 -0400
Date: Thu, 20 Apr 2006 06:29:51 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060420112951.GA18604@sergelap.austin.ibm.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73mzeh2o38.fsf@bragg.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andi Kleen (ak@suse.de):
> Arjan van de Ven <arjan@infradead.org> writes:
> > 
> > you must have a good defense against that argument, so I'm curious to
> > hear what it is
> 
> [I'm not from the apparmor people but my understanding is]
> 
> Usually they claimed name spaces as the reason it couldn't work.
> 
> In practice AFAIK basically nobody uses name spaces for
> anything.  AppArmor just forbids mounts/CLONE_NEWNS for the confined

Well, I use them all over the place to keep accounts on separate /tmp's,
etc.  It may not be the norm yet, but the general availability of
pam_mount etc, and the implementation of shared subtrees may well change
that.

But then if that happens, as Al points out, AA might be able to
embrace rather than fight it.

-serge
