Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUBMKOF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUBMKOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:14:05 -0500
Received: from ss1000-dmz.ms.mff.cuni.cz ([195.113.20.8]:12526 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266892AbUBMKOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:14:03 -0500
Date: Fri, 13 Feb 2004 11:13:51 +0100
From: Rudo Thomas <rudo@matfyz.cz>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: bug, or is it? - SCHED_RR and futex related
Message-ID: <20040213101351.GB19072@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Nick Piggin <piggin@cyberone.com.au>
References: <20040212205708.GA1679@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212205708.GA1679@ss1000.ms.mff.cuni.cz>
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last question.

I tracked it down to an infinite waiting in futex( ..., FUTEX_WAIT, 2, NULL).
Can THIS hang the machine hard when running with SCHED_RR policy?

Thanks.

Rudo.
