Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261736AbSI2Ss5>; Sun, 29 Sep 2002 14:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbSI2Ss5>; Sun, 29 Sep 2002 14:48:57 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:63624 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261736AbSI2Sru>;
	Sun, 29 Sep 2002 14:47:50 -0400
Date: Sun, 29 Sep 2002 19:54:55 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
Message-ID: <20020929185455.GA28248@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	William Lee Irwin III <wli@holomorphy.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	"David S. Miller" <davem@redhat.com>
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 07:52:17PM +0200, Ingo Molnar wrote:
 > 
 > the attached patch is the smptimers patch plus the removal of old BHs and
 > a rewrite of task-queue handling.

As an aside, some of the stuff in Documentation/ like Rusty's various
guides are now woefully out of date with whats happening in 2.5
Yet another small project for someone with too much time on their
hands would be to go through this, deleting the obsolete stuff, and
updating the locking documentation to reflect new issues like
preemption.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
