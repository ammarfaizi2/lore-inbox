Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318206AbSGWT4o>; Tue, 23 Jul 2002 15:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318209AbSGWT4o>; Tue, 23 Jul 2002 15:56:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48053 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318206AbSGWT4n>;
	Tue, 23 Jul 2002 15:56:43 -0400
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
From: Paul Larson <plars@austin.ibm.com>
To: dmccr@us.ibm.com
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Rik van Riel <riel@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       haveblue@us.ibm.com
In-Reply-To: <1027450930.7700.26.camel@plars.austin.ibm.com>
References: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com>
	<1027377273.5170.37.camel@plars.austin.ibm.com>
	<20020722225251.GG919@holomorphy.com>
	<1027446044.7699.15.camel@plars.austin.ibm.com> 
	<20020723174942.GL919@holomorphy.com> 
	<1027450930.7700.26.camel@plars.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Jul 2002 14:57:19 -0500
Message-Id: <1027454241.7700.34.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was asking Dave McCracken and he mentioned that rmap and highmem pte
don't play nice together.  I tried turning that off and it boots without
error now.  Someone might want to take a look at getting those two to
work cleanly together especially now that rmap is in.  But for now, this
will work around the problem.

Thanks,
Paul Larson

