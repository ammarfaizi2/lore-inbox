Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVHCL4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVHCL4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVHCL4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:56:07 -0400
Received: from gold.veritas.com ([143.127.12.110]:45843 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262260AbVHCLzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:55:17 -0400
Date: Wed, 3 Aug 2005 12:57:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <OFE9263DCA.5243AC8F-ON42257052.0038D22F-42257052.00392CDD@de.ibm.com>
Message-ID: <Pine.LNX.4.61.0508031251140.14149@goblin.wat.veritas.com>
References: <OFE9263DCA.5243AC8F-ON42257052.0038D22F-42257052.00392CDD@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Aug 2005 11:55:16.0854 (UTC) FILETIME=[36F93960:01C59822]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005, Martin Schwidefsky wrote:
> Hugh Dickins <hugh@veritas.com> wrote on 08/02/2005 10:55:31 PM:
> >
> > Here we are: get_user_pages quite untested, let alone the racy case,
> 
> Ahh, just tested it and everythings seems to work (even for s390)..
> I'm happy :-)

Thanks for testing, Martin.  Your happiness is my bliss.  Whether
we go with Nick's mods on mine or not, I think you can now safely
assume we've given up demanding a sudden change at the s390 end.

Hugh
