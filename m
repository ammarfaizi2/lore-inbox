Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWD3PhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWD3PhH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 11:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWD3PhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 11:37:07 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:11373 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751152AbWD3PhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 11:37:06 -0400
Subject: Re: [BUG] 2.6.15-rt16 __cache_alloc at mm/slab.c
From: Daniel Walker <dwalker@mvista.com>
To: Noah Watkins <noah.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <be2dacd50604292022i276adae4yfb5877b71a23c87@mail.gmail.com>
References: <be2dacd50604292022i276adae4yfb5877b71a23c87@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 08:37:03 -0700
Message-Id: <1146411424.2446.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-29 at 22:22 -0500, Noah Watkins wrote:
> 2.6.15-rt16 compiled w/o SMP support has been working fine. On the
> same hardware (dual p3) with SMP compiled in I am getting BUGS.
> 
> The computer boots fine, and the following (trace at end of email)
> occurs after I log into the computer over SSH. Specifically I am
> prompted for my password and immediately after I submit my password to
> SSH the box goes crazy.
> 

It looks an error interrupt from the APIC . You could try booting with
the "noapic" option, or try UP w/ Local APIC and IO-APIC support on ..

Daniel

