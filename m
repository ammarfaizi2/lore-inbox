Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbRETPhx>; Sun, 20 May 2001 11:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbRETPhn>; Sun, 20 May 2001 11:37:43 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:60908 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S262045AbRETPhf>; Sun, 20 May 2001 11:37:35 -0400
Date: Sun, 20 May 2001 17:32:52 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
Message-ID: <20010520173252.Q754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0105191840250.5531-100000@imladris.rielhome.conectiva> <Pine.LNX.4.33.0105200509130.488-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0105200509130.488-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Sun, May 20, 2001 at 05:29:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 05:29:49AM +0200, Mike Galbraith wrote:
> I'm not sure why that helps.  I didn't put it in as a trick or
> anything though.  I put it in because it didn't seem like a
> good idea to ever have more cleaned pages than free pages at a
> time when we're yammering for help.. so I did that and it helped.

The rationale for this is easy: free pages is wasted memory,
clean pages is hot, clean cache. The best state a cache can be in.

Regards

Ingo Oeser
-- 
To the systems programmer,
users and applications serve only to provide a test load.
