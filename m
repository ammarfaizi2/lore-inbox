Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTJLMI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 08:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTJLMI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 08:08:58 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:23462
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S263470AbTJLMI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 08:08:57 -0400
Date: Sun, 12 Oct 2003 08:08:31 -0400 (EDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Mike Galbraith <efault@gmx.de>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test7 DEBUG_PAGEALLOC oops
In-Reply-To: <5.2.1.1.2.20031012105054.01e34bc8@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0310120806130.29523-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Oct 2003, Mike Galbraith wrote:

> At 08:58 AM 10/12/2003 +0200, Manfred Spraul wrote:
> >Could you try the attached patch?
> >It updates the end of stack detection to handle unaligned stacks.
> 
> Works fine.  (modulo moving kstack_end above ASSEMBLY)

I'm the one with bugzilla 973.  I'm trying the patch with a source tree 
synced up from bk this morning and having a few problems.  My in-laws are 
visiting today, so my work on this will be intermittent.  I am interested, 
however.

