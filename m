Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUGHXmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUGHXmD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 19:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUGHXmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 19:42:03 -0400
Received: from holomorphy.com ([207.189.100.168]:19944 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261300AbUGHXmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 19:42:00 -0400
Date: Thu, 8 Jul 2004 16:41:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Mike Galbraith'" <efault@gmx.de>, "'akpm@osdl.org'" <akpm@osdl.org>,
       "'rml@tech9.net'" <rml@tech9.net>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Con Kolivas'" <kernel@kolivas.org>, "'Elladan'" <elladan@eskimo.com>,
       "'Chris Siebenmann'" <cks@utcc.utoronto.ca>
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum	) que stio n
Message-ID: <20040708234125.GQ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Williams <pwil3058@bigpond.net.au>,
	"Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	'Mike Galbraith' <efault@gmx.de>, "'akpm@osdl.org'" <akpm@osdl.org>,
	"'rml@tech9.net'" <rml@tech9.net>, 'Ingo Molnar' <mingo@elte.hu>,
	'Con Kolivas' <kernel@kolivas.org>, 'Elladan' <elladan@eskimo.com>,
	'Chris Siebenmann' <cks@utcc.utoronto.ca>
References: <313680C9A886D511A06000204840E1CF08F42FE6@whq-msgusr-02.pit.comms.marconi.com> <40EDD980.4040608@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EDD980.4040608@bigpond.net.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Povolotsky, Alexander wrote:
>> Is there a chance such functionality will make into Linux 2.6 as a patch 
>> (at some later time) ?

On Fri, Jul 09, 2004 at 09:32:16AM +1000, Peter Williams wrote:
> Not until the current scheduler is replaced with a single priority array 
> scheduler.  However, if there's enough interest, I could add this 
> functionality to the CPU scheduler evaluation patch so that people could 
> experiment with it (BUT it would be at the bottom of my to do list).

Well, this is in part because it makes the assumption of such a data
structure and then does if (scheduler_type == FOO) { /* FOO's thing */ }
in the midst of various manipulations of the struture instead of having
methods for higher-level scheduler operations.

As certain reputable news sources have said, I wish people would write
more ambitious scheduler patches. =)


-- wli
