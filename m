Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVBGQpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVBGQpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVBGQpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:45:40 -0500
Received: from alphan.student.Princeton.EDU ([140.180.161.103]:13707 "EHLO
	mevlevi") by vger.kernel.org with ESMTP id S261187AbVBGQp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:45:27 -0500
Subject: Re: Suggestion for CD filesystem for Backups
From: Ali Bayazit <listeci@bayazit.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Judith und Mirko Kloppstech <jugal@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095956209.6776.36.camel@localhost.localdomain>
References: <415204E0.9010203@gmx.net>
	 <1095956209.6776.36.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Sep 2004 01:18:19 -0400
Message-Id: <1096003099.16849.16.camel@mevlevi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2004-09-23 at 17:16 +0100, Alan Cox wrote:
> On Iau, 2004-09-23 at 00:04, Judith und Mirko Kloppstech wrote:
> > Why not write a file system on top of ISO9660 which uses the rest of the 
> > CD to write error correction. If a sector becomes unreadable, the error 
> > correction saves the data. Besides, a tool for testing the error rate 
> > and the safety of the data can be easily written for a normal CD-ROM drive.
> > 
> > The data for error correction might be written into a file so that the 
> > CD can be read using any System, but Linux provides error correction.
> 
> Send patches, or possibly if you are dumping tars and the like just
> write yourself an app to generate a second file of ECC data.
> 
Wouldn't it be safer to do ECC on meta-data also?
That probably means replacing ISO9660 though.

-ali

-- 
Ali Bayazit <listeci@bayazit.net>
