Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbTFMGXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTFMGXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:23:46 -0400
Received: from palrel11.hp.com ([156.153.255.246]:10158 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265170AbTFMGXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 02:23:45 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16105.28970.526326.249287@napali.hpl.hp.com>
Date: Thu, 12 Jun 2003 23:37:30 -0700
To: Roland McGrath <roland@redhat.com>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: FIXMAP-related change to mm/memory.c
In-Reply-To: <200306130634.h5D6YZ523894@magilla.sf.frob.com>
References: <16105.13317.608868.581471@napali.hpl.hp.com>
	<200306130634.h5D6YZ523894@magilla.sf.frob.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 12 Jun 2003 23:34:35 -0700, Roland McGrath <roland@redhat.com> said:

  Roland> Linus's suggested change is obviously the minimal change
  Roland> from what we have now.  But the arch_get_user_pages idea
  Roland> might be the more conservative implementation compared to
  Roland> the status quo before my get_user_pages patch.

Could you test Linus' proposal?  It would definitely do the trick for
ia64.

	--david
