Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbUCHRyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 12:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbUCHRyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 12:54:45 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:31686 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262685AbUCHRym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 12:54:42 -0500
Date: Mon, 8 Mar 2004 12:54:38 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andy Isaacson <adi@hexapodia.org>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
In-Reply-To: <404C92CD.6090208@nortelnetworks.com>
Message-ID: <Pine.LNX.4.58.0403081253280.29087@montezuma.fsmlabs.com>
References: <20040307144921.GA189@elf.ucw.cz> <20040307164052.0c8a212b.akpm@osdl.org>
 <20040308063639.GA20793@hexapodia.org> <1078738772.4678.5.camel@laptop.fenrus.com>
 <404C8CBB.1030008@nortelnetworks.com> <20040308151625.GC3999@devserv.devel.redhat.com>
 <404C92CD.6090208@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2004, Chris Friesen wrote:

> Arjan van de Ven wrote:
>
> > that is what it guarantees. it guarantees that you don't hard-fault.
> > The rest of the manpage talks about potential usages but immediatly
> > describes the crypto one as non-solid
>
> Guess I've got older manpages...mine don't have the caveats.

POSIX don't mention sample usage or caveats either, it only
states guaranteed memory residency.
