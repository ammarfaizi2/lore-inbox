Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVAAFti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVAAFti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 00:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVAAFth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 00:49:37 -0500
Received: from [66.35.79.110] ([66.35.79.110]:62399 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261748AbVAAFth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 00:49:37 -0500
Date: Fri, 31 Dec 2004 21:49:25 -0800
From: Tim Hockin <thockin@hockin.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APIC, changing level/edge interrupt
Message-ID: <20050101054925.GA13925@hockin.org>
References: <41D1977D.2000600@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D1977D.2000600@drzeus.cx>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 06:27:25PM +0100, Pierre Ossman wrote:
> How do you tell the APIC that a device uses level triggered interrupts, 
> not edge triggered? I have a flash reader on the LPC bus which uses 
> level triggered interrupts and /proc/interrupts show edge triggered. 
> Some interrupts are missed by the APIC so I figured this might be why.

BIOS should set this up.  Maybe ACPI has a way to do this?
