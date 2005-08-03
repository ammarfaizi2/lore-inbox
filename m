Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVHCK2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVHCK2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVHCK0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:26:54 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:27536 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262207AbVHCKYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:24:37 -0400
In-Reply-To: <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OFE9263DCA.5243AC8F-ON42257052.0038D22F-42257052.00392CDD@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 3 Aug 2005 12:24:30 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 03/08/2005 12:24:33
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote on 08/02/2005 10:55:31 PM:

> > Go for it, I think whatever we do won't be wonderfully pretty.
>
> Here we are: get_user_pages quite untested, let alone the racy case,
> but I think it should work.  Please all hack it around as you see fit,
> I'll check mail when I get home, but won't be very responsive...

Ahh, just tested it and everythings seems to work (even for s390)..
I'm happy :-)

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

