Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUF1IuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUF1IuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 04:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbUF1IuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 04:50:00 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:30851 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264904AbUF1It6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 04:49:58 -0400
Message-ID: <40DFDBB2.7010800@yahoo.com.au>
Date: Mon, 28 Jun 2004 18:49:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Con Kolivas <kernel@kolivas.org>, Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de>	 <200406261929.35950.mbuesch@freenet.de>	 <1088363821.1698.1.camel@teapot.felipe-alfaro.com>	 <200406272128.57367.mbuesch@freenet.de>	 <1088373352.1691.1.camel@teapot.felipe-alfaro.com>	 <Pine.LNX.4.58.0406281013590.11399@kolivas.org> <1088412045.1694.3.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1088412045.1694.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:

> I have tested 2.6.7-bk10 plus from_2.6.7_to_staircase_7.7 patch and,
> while it's definitively better than previous versions, it still feels a
> little jerky when moving windows in X11 wrt to -mm3. Renicing makes it a
> little bit smoother, but not as much as -mm3 without renicing.
> 

You know, if renicing X makes it smoother, then that is a good thing
IMO. X needs large amounts of CPU and low latency in order to get
good interactivity, which is something the scheduler shouldn't give
to a process unless it is told to.
