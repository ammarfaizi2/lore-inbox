Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbULOAS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbULOAS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbULOAR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:17:26 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:50824 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261785AbULNXi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:38:27 -0500
Message-ID: <41BF7966.20009@nortelnetworks.com>
Date: Tue, 14 Dec 2004 17:38:14 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
References: <20041211142317.GF16322@dualathlon.random>	 <20041212163547.GB6286@elf.ucw.cz>	 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>	 <Pine.LNX.4.61.0412130928350.2394@yvahk01.tjqt.qr> <1103064879.14699.75.camel@krustophenia.net>
In-Reply-To: <1103064879.14699.75.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> Ugh, because mplayer stupidly does disk i/o and AV playback and GUI in
> the same thread.  Insert Xine plug.

This is not a problem as long as all of them can be done totally async.  As soon 
as anything blocks, then there's an issue.

Chris
