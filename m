Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266962AbUAXQBo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 11:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266966AbUAXQBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 11:01:44 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:45460
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S266962AbUAXQBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 11:01:43 -0500
Date: Sat, 24 Jan 2004 11:12:35 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Illegal instruction with gl
Message-ID: <20040124111235.A2757@animx.eu.org>
References: <20040123181512.A6632@animx.eu.org> <20040124103919.A7924@animx.eu.org> <20040124154249.GA2499@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20040124154249.GA2499@redhat.com>; from Dave Jones on Sat, Jan 24, 2004 at 03:42:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I see no evidence that this is an agpgart problem.  When that does something
> wrong, you usually end up with either a system lockup, or massive memory
> corruption. Apps segfaulting would suggest to me that you have a problem with
> your X GL libraries.
> 
> You may have more luck asking the folks at dri-devel@lists.sf.net about it.

Considering that all I did was change the motherboard, it could be an agp
problem.  This same card, same kernel, everything worked on another system. 
I did not change any other software other than the kernel.

The program did not segfault, it received illegal instruction.  The only
driver that I had to change when I installed this board was the aic79xx. 
The other system used an addon aic7xxx controller, this has a builtin
aic7902 controller which houses /

I'll forward my same message to that list you mentioned.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
