Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVDUHNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVDUHNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVDUHNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:13:34 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:34457 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261228AbVDUHN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:13:27 -0400
Subject: Re: [patch] fix race in __block_prepare_write (again)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.60.0504210757220.3348@hermes-1.csi.cam.ac.uk>
References: <1114064046.5182.13.camel@npiggin-nld.site>
	 <Pine.LNX.4.60.0504210757220.3348@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 17:13:19 +1000
Message-Id: <1114067599.5182.17.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 08:01 +0100, Anton Altaparmakov wrote:

> Any reason why you left the goto out?  It would be IMO much cleaner to 
> remove the label "out" altogether and replace the single "goto out" with a 
> "break" (which is fine since the goto happens inside the for loop 
> immediately after which you place the label.)
> 

No reason at all ;)


-- 
SUSE Labs, Novell Inc.


