Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbWJERb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbWJERb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWJERb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:31:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:56285 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751395AbWJERb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:31:29 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Thu, 5 Oct 2006 19:27:27 +0200
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <Pine.LNX.4.64.0610051014550.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610051014550.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051927.27255.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Have you actually ever seen an alignment check in the kernel? 

No. It was me extrapolating from Marcus' report, but I apparently
didn't read the specification well enough.

> As far as I  
> know, the AC flag is only effective in user space, and anything else would 
> be in violation of the whole definition of the AC flag. The i486 manual 
> explicitly states that AC events are _only_ handled in ring3.
> 
> So I think these both are (a) misleading and (b) wrong.

Ok. Please drop them then.

-Andi
