Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbUCJRsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 12:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbUCJRsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 12:48:06 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:14535 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262723AbUCJRsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 12:48:04 -0500
Date: Wed, 10 Mar 2004 18:47:50 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       corliss@digitalmages.com, riel@redhat.com, jerj@coplanar.net
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <1078936898.2232.571.camel@cube>
Message-ID: <Pine.LNX.4.53.0403101844140.15085@gockel.physik3.uni-rostock.de>
References: <1078883951.2232.501.camel@cube> 
 <Pine.LNX.4.53.0403100940240.12833@gockel.physik3.uni-rostock.de>
 <1078936898.2232.571.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Albert Cahalan wrote:

> That's a 42-bit number instead of a 36-bit one.

OK, your format clearly wins. Especially since I think that comp_t can
only encode a 34-bit number.

But I favor your suggestion of 32-bit IEEE floats even more,
as it doesn't need a change to the GNU acct tools.

Sorry for the confusion

Tim
