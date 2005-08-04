Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVHDViE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVHDViE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVHDVez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:34:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262709AbVHDVeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:34:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: george@mvista.com
X-Fcc: ~/Mail/linus
Cc: Gerd Knorr <kraxel@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.6.12: itimer_real timers don't survive execve() any
 more
In-Reply-To: George Anzinger's message of  Thursday, 4 August 2005 14:22:15 -0700 <42F28707.7060806@mvista.com>
X-Zippy-Says: I always have fun because I'm out of my mind!!!
Message-Id: <20050804213416.1EA56180980@magilla.sf.frob.com>
Date: Thu,  4 Aug 2005 14:34:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's wrong.  It has to be done only by the last thread in the group to go.
Just revert Ingo's change.


Thanks,
Roland
