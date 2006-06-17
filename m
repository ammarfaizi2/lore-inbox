Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWFQDqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWFQDqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 23:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWFQDqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 23:46:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17805 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751588AbWFQDqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 23:46:39 -0400
Date: Fri, 16 Jun 2006 23:46:33 -0400
From: Dave Jones <davej@redhat.com>
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AGPGART: unable to get memory for graphics translation table.
Message-ID: <20060617034633.GC2893@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ian Kent <raven@themaw.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0606171125390.2748@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606171125390.2748@raven.themaw.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 11:32:24AM +0800, Ian Kent wrote:
 > 
 > Hi all,
 > 
 > I've been having trouble with my Radeon card not working with X.
 > 
 > 01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AS [Radeon 
 > 9550]
 > 
 > The only thing I can find that may be a clue is:
 > 
 > Jun 17 11:12:48 raven kernel: agpgart: Detected AGP bridge 0
 > Jun 17 11:12:48 raven kernel: agpgart: unable to get memory for graphics 
 > translation table.
 > Jun 17 11:12:48 raven kernel: agpgart: agp_backend_initialize() failed.
 > Jun 17 11:12:48 raven kernel: agpgart-amd64: probe of 0000:00:00.0 failed 
 > with error -12
 
Is this with the free Xorg drivers, or the ATI fglx thing ?
I don't think I've ever seen agp_generic_create_gatt_table() fail before,
and that hasn't changed for a looong time.

		Dave

-- 
http://www.codemonkey.org.uk
