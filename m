Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275258AbTHSAaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275260AbTHSAaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:30:08 -0400
Received: from holomorphy.com ([66.224.33.161]:49641 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S275258AbTHSAaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:30:04 -0400
Date: Mon, 18 Aug 2003 17:31:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
Message-ID: <20030819003110.GY32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Wes Janzen <superchkn@sbcglobal.net>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030817003128.04855aed.voluspa@comhem.se> <200308171142.33131.kernel@kolivas.org> <20030817073859.51021571.voluspa@comhem.se> <200308172336.42593.kernel@kolivas.org> <3F416BD4.3040302@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F416BD4.3040302@sbcglobal.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 07:14:12PM -0500, Wes Janzen wrote:
> That makes sense, I was running a program that I found on IBM's website 
> that's supposed to test context switching speed this weekend.  It has 1 
> free lock and passes them around the group.  If I put it up to 32 
> threads or so with one spare lock, I can start to see the starvation.  
> When running vmstat, it's apparent when the the starvation occurs as the 
> context switching sky-rockets.  I was going to add to the example code 
> to check for how many times a thread wakes up waiting for the lock and 
> can't get it after reading that message about locks in the list.  I 
> guess I won't have to do that now.  Anyway, that'll bring my system to a 
> halt when the thread count gets up over 256.  Still, it's usuable as 
> long as I'm not doing something else that makes heavy use of the processor.

Could you give a URL to that benchmark?

Thanks.


-- wli
