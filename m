Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030852AbWKOSoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030852AbWKOSoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030856AbWKOSoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:44:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:10716 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030852AbWKOSoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:44:23 -0500
From: Andi Kleen <ak@suse.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] ACPI: use MSI_NOT_SUPPORTED bit
Date: Wed, 15 Nov 2006 19:44:12 +0100
User-Agent: KMail/1.9.5
Cc: len.brown@intel.com, Linus Torvalds <torvalds@osdl.org>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <p73ejs5co0q.fsf@bingen.suse.de> <20061115103525.19e9d3eb.randy.dunlap@oracle.com>
In-Reply-To: <20061115103525.19e9d3eb.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151944.12415.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 19:35, Randy Dunlap wrote:
> On 15 Nov 2006 05:49:41 +0100 Andi Kleen wrote:
> 
> > BTW there seems to be a new ACPI FADT bit that says "MSI is broken"
> > We should probably check that too as a double check.
> 
> Do you mean more than just use that bit when you say "double check"?
> 
> I wonder why this hasn't already been done. (?)

Nobody coded it yet.

> How's this look?  Build-tested only.

There should be probably a command line option to overwrite it

-Andi
