Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbUKVR0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUKVR0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUKVRZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:25:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:1411 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262260AbUKVRUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:20:03 -0500
Date: Mon, 22 Nov 2004 11:19:32 -0600
From: Robin Holt <holt@sgi.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: scalability of signal delivery for Posix Threads
Message-ID: <20041122171932.GA19440@lnx-holt.americas.sgi.com>
References: <41A20AF3.9030408@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A20AF3.9030408@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 09:51:15AM -0600, Ray Bryant wrote:
> We've encountered a scalability problem with signal delivery.  Our 
> application
> is attempting to use ITIMER_PROF to deliver one signal per clock tick to 
> each
> thread of a ptrheaded (NPTL).  These threads are created with CLONE_SIGHAND,
> so that there is a single sighand->siglock for the entire application.

Ray, can you provide a simple example application that trips this case?
