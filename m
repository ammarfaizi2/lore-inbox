Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWBHLCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWBHLCC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 06:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWBHLCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 06:02:02 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:28174 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S964874AbWBHLCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 06:02:00 -0500
Date: Wed, 8 Feb 2006 11:01:52 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH 02/17] mips: namespace pollution - mem_... -> __mem_...
 in io.h
In-Reply-To: <E1F6jSx-0002TE-Ur@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.64N.0602081059020.27639@blysk.ds.pg.gda.pl>
References: <E1F6jSx-0002TE-Ur@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Al Viro wrote:

> A pile of internal functions use only inside mips io.h has names starting
> with mem_... and clashing with names in drivers; renamed to __mem_....

 Then the corresponding ones with no "mem_" prefix (these for the PCI I/O 
port space) should be prefixed with "__" for consistency as well.

  Maciej
