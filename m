Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTD2XAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 19:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTD2XAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 19:00:11 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:36059 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261917AbTD2XAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 19:00:10 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to return -E Linux 2.5.68
Date: Tue, 29 Apr 2003 23:11:24 +0000
User-Agent: KMail/1.5.1
References: <200304292215.20590.devenyga@mcmaster.ca> <20030429224228.GQ10374@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030429224228.GQ10374@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304292311.24117.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was intended to do exactly what the KernelJanitor TODO and kj.pl script 
pointed out, but aparently there's more to it than that. (BTW it just says 
"sed s/return EWHATEVER/return -EWHATEVER/") Discouraging people with foul 
language isn't the best way to get more developers, this is only my first 
try.

-- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca

On April 29, 2003 10:42 pm, you wrote:
> On Tue, Apr 29, 2003 at 10:15:20PM +0000, Gabriel Devenyi wrote:
> > This patch applies to 2.5.68. It converts all the remaining error returns
> > to the new return -E form, this is in the KernelJanitor TODO list.
> >
> > http://muss.mcmaster.ca/~devenyga/patch-linux-2.5.68-return-errors.patch
> >
> > Please CC me with any discussion since I do not subscribe to lkml
>
> Have you tried to compile the patched kernel?
>
> Patch is bogus - most of the changes are s/return ERR_PTR(foo)/return foo/
> with neither explanation nor change of function prototype not change of
> other exits from these functions.
>
> WTF was it intended to do?

-- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca
