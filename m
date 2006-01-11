Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWAKNyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWAKNyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWAKNyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:54:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:63655 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751624AbWAKNyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:54:50 -0500
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Date: Wed, 11 Jan 2006 14:50:07 +0100
User-Agent: KMail/1.8.2
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net> <200601111212.40989.ak@suse.de> <20060111134230.GE4990@in.ibm.com>
In-Reply-To: <20060111134230.GE4990@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111450.07996.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 14:42, Vivek Goyal wrote:

> While testing this I ran into another problem with same symtoms. If 
> I compile my kernel for physical location greater than or equal to 
> 16MB then only BP boots and applicatoin processors don't come up. I had
> noticed this problem in i386 and posted a patch. Here is the similar  patch 
> for x86_64.
> 
> Though the symtoms are same but this does not seem to be related to the
> problem which Stephen is facing as he seems to be compiling the kernel
> for 1MB location only.

I don't think that's Stephen's problem.

-Andi
