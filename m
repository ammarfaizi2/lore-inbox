Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUHBNjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUHBNjD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266521AbUHBNjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:39:03 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:47239 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266519AbUHBNjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:39:00 -0400
Date: Mon, 2 Aug 2004 14:37:46 +0100
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: finding out the boot cpu number from userspace
Message-ID: <20040802133746.GA27758@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
References: <20040802121635.GE14477@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802121635.GE14477@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 02:16:35PM +0200, Arjan van de Ven wrote:
 > Hi,
 > 
 > assuming cpu 0 is the boot cpu sounds fragile/incorrect, but for irqbalanced
 > I'd like to find out which cpu is the boot cpu, is there a good way of doing
 > so ?

Parsing MP tables ?  Don't know how well this holds up in a post-MP
ACPI world though.  x86info has some code for this already, which I
stole from some other program I long since forgot about.

		Dave

