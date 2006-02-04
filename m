Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160995AbWBDPT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbWBDPT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 10:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160996AbWBDPT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 10:19:27 -0500
Received: from silver.veritas.com ([143.127.12.111]:50220 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1160995AbWBDPT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 10:19:26 -0500
Date: Sat, 4 Feb 2006 15:20:00 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: yipee <yipeeyipeeyipeeyipee@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: changing physical page
In-Reply-To: <loom.20060204T152816-726@post.gmane.org>
Message-ID: <Pine.LNX.4.61.0602041518230.8867@goblin.wat.veritas.com>
References: <loom.20060202T160457-366@post.gmane.org>
 <Pine.LNX.4.61.0602021711110.8796@goblin.wat.veritas.com>
 <loom.20060204T152816-726@post.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Feb 2006 15:19:24.0095 (UTC) FILETIME=[6151A4F0:01C6299E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, yipee wrote:
> Hugh Dickins <hugh <at> veritas.com> writes:
> > I'll assume that when you say "page owned by a user program", you're
> > meaning a private page, not a shared file page mapped into the program.
> > 
> > If you're asking about what currently happens, the answer is "No".
> > 
> > If you're asking about what you can assume, the answer is "Yes".
> 
> So you are saying that the current kernel doesn't move these kind of pages?

If you don't have swap (one of the conditions you gave), yes.

> but it may in future versions?

Yes.
