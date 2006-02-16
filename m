Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWBPReU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWBPReU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWBPReT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:34:19 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:23025 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932540AbWBPReT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:34:19 -0500
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060216172435.GC29151@elte.hu>
References: <20060216094130.GA29716@elte.hu>
	 <1140107585.21681.18.camel@localhost.localdomain>
	 <20060216172435.GC29151@elte.hu>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 09:34:16 -0800
Message-Id: <1140111257.21681.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 18:24 +0100, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > Another thing I noticed was that futex_offset on the surface looks 
> > like a malicious users dream variable .. [...]
> 
> i have no idea what you mean by that - could you explain whatever threat 
> you have in mind, in more detail?

	As I said, "on the surface" you could manipulate the futex_offset to
access memory unrelated to the futex structure . That's all I'm
referring too .. 

Daniel

