Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVAEB1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVAEB1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVAEB1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:27:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:28070 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262192AbVAEB1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:27:11 -0500
Date: Tue, 4 Jan 2005 17:26:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V3 [1/4]: Allow request for zeroed memory
In-Reply-To: <Pine.LNX.4.58.0501041715280.2222@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501041724050.4111@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
  <41C20E3E.3070209@yahoo.com.au>  <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
  <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com> 
 <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be> 
 <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
 <1104882342.16305.12.camel@localhost> <Pine.LNX.4.58.0501041715280.2222@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jan 2005, Christoph Lameter wrote:
> 
> Ahh. Great. Do I need to submit a corrected patch that removes those two
> lines or is it fine as is?

Please do split it up into a function of its own. It's going to look a lot 
prettier as an intermediate phase. I realize that that touches #3 in the 
series, but I suspect that one will also just be prettier as a result.

		Linus
