Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVGLGiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVGLGiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 02:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVGLGiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 02:38:16 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:53917 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261192AbVGLGiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 02:38:15 -0400
Subject: Re: [PATCH] [5/48] Suspend2 2.1.9.8 for 2.6.12:
	350-workthreads.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Hellwig <hch@infradead.org>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710230441.GC513@infradead.org>
References: <11206164393426@foobar.com> <112061643920@foobar.com>
	 <20050710230441.GC513@infradead.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121150400.13869.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 16:40:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 09:04, Christoph Hellwig wrote:
> Again, why do you think you need this?

1. If something should be wrong with the freezer, it forms part of a
safety net that stops your data on disk being trashed.
2. Separating out threads doing syncing from threads submitting I/O
makes the refrigerator much more reliable, even under extreme load.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

