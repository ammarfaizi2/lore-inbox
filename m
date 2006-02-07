Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWBGJka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWBGJka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWBGJka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:40:30 -0500
Received: from cantor2.suse.de ([195.135.220.15]:62363 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932457AbWBGJk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:40:29 -0500
From: Andi Kleen <ak@suse.de>
To: ltuikov@yahoo.com
Subject: Re: [PATCH] x86-64: improve the format of stack dumps
Date: Tue, 7 Feb 2006 10:20:47 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, rdunlap@xenotime.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <20060207051352.11432.qmail@web31802.mail.mud.yahoo.com>
In-Reply-To: <20060207051352.11432.qmail@web31802.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071020.47999.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 06:13, Luben Tuikov wrote:
> Improve the format of stack dumps for x86-64.
> * Single column of stack entries. (similar to other arches)

I don't like that part as I wrote earlier.It's a waste of precious
screen space, no matter how often you retransmit the patch.  The old
format had a chance to even fit on a 80x25 screen, with your new one
it is extremly unlikely.

Overall you're making less information available in a common case
for cosmetics.

-Andi
