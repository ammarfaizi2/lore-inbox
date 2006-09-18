Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWIRTBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWIRTBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWIRTBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:01:06 -0400
Received: from gw.goop.org ([64.81.55.164]:59309 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932265AbWIRTBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:01:04 -0400
Message-ID: <450EECEC.207@goop.org>
Date: Mon, 18 Sep 2006 12:01:00 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Benjamin LaHaise <bcrl@kvack.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Sysenter crash with Nested Task Bit set
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com> <200609181729.23934.ak@suse.de> <20060918161251.GC19815@kvack.org> <200609181839.45546.ak@suse.de>
In-Reply-To: <200609181839.45546.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Yes it's never fast, but on basically all non P4 CPUs it is still fast enough
> to not be a problem. I suppose it causes a trace cache flush or something like
> that there.

I don't think it's that bad, but it might cause a full pipeline flush.  
I seem to remember measuring its cost at about 50 cycles.

    J

