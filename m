Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbUD3Vf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUD3Vf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUD3Vf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:35:59 -0400
Received: from [12.177.129.25] ([12.177.129.25]:65475 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261419AbUD3Vfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:35:52 -0400
Message-Id: <200404302217.i3UMHdml004610@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Shailabh <nagar@watson.ibm.com>
cc: Rik van Riel <riel@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release 
In-Reply-To: Your message of "Fri, 30 Apr 2004 15:47:44 EDT."
             <4092AD60.1030809@watson.ibm.com> 
References: <20040430174117.A13372@infradead.org> <Pine.LNX.4.44.0404301502550.6976-100000@chimarrao.boston.redhat.com>  <4092AD60.1030809@watson.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 30 Apr 2004 18:17:39 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nagar@watson.ibm.com said:
> Jeff, do you have any numbers for UML overhead in 2.6 ? 

It obviously depends on the workload, but for "normal" things, like kernel
builds and web serving, it's generally in the 20-30% range.  That can be 
reduced, since I haven't spent too much time on tuning.  I'm aiming for the
teens, and I don't think that'll be too hard.

				Jeff

