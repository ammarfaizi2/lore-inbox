Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWFMRTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWFMRTS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWFMRTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:19:18 -0400
Received: from ns2.suse.de ([195.135.220.15]:44008 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932149AbWFMRTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:19:17 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of physical_pages_backing it
Date: Tue, 13 Jun 2006 19:18:56 +0200
User-Agent: KMail/1.9.3
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Linux-mm@kvack.org, arjan@infradead.org,
       jengelh@linux01.gwdg.de
References: <787b0d920606122253o4f1a9e18x1ca49c3ce005696f@mail.gmail.com> <200606130756.52669.ak@suse.de> <1150218637.9576.73.camel@galaxy.corp.google.com>
In-Reply-To: <1150218637.9576.73.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131918.56772.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Providing useful information about memory consumption is hardly
> debugging kludge. 

I strongly believe anything that shows virtual addresses is for debugging
only. If your monitoring systems needs to look at VMAs it is doing
something very wrong or trying to do something that shouldn't be 
in user space.

-Andi
