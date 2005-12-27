Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVL0EFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVL0EFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 23:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVL0EFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 23:05:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46536 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932207AbVL0EFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 23:05:01 -0500
Date: Mon, 26 Dec 2005 23:04:52 -0500
From: Dave Jones <davej@redhat.com>
To: jeff shia <tshxiayu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: do we still need the jiffies wraparound functions ?
Message-ID: <20051227040452.GA27781@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	jeff shia <tshxiayu@gmail.com>, linux-kernel@vger.kernel.org
References: <7cd5d4b40512261932v12149210u52cf97c4bc203871@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd5d4b40512261932v12149210u52cf97c4bc203871@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 11:32:41AM +0800, jeff shia wrote:
 > Hello,
 > 
 > Under the kernel 2.6.x,the jiffies is defined as u64.We cannot count
 > on it to overflow.

You can guarantee it will overflow within a few minutes of booting.
This is done deliberatly to catch jiffy-wrap bugs.

 > Do we still need the functions to solve this problem?

yes.

		Dave
