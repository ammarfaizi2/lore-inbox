Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTE0PRr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTE0PRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:17:46 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.46]:49815 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263847AbTE0PQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:16:36 -0400
From: DevilKin-LKML <devilkin-lkml@blindguardian.org>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Linux 2.5.70 compile error
Date: Tue, 27 May 2003 17:29:48 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com>
In-Reply-To: <20030527130515.GH8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305271729.49047.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 15:05, William Lee Irwin III wrote:
> I suspect you're attempting to shoot yourself in the foot. .config?

Ah, quite. I saw NUMA was activated, and disabling it fixed my problem. Odd 
though, that it should become active just by doing a 'make oldconfig' with my 
2.7.69 config file...

Anywayz, it works, this kernel solves all my outstanding issues sofar (being 
mostly with the irda) so I'm happy :P

Jan
-- 
You look like a million dollars.  All green and wrinkled.

