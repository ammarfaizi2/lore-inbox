Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131511AbRBES4i>; Mon, 5 Feb 2001 13:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbRBES42>; Mon, 5 Feb 2001 13:56:28 -0500
Received: from cj30520-a.manss1.va.home.com ([24.7.169.75]:24837 "EHLO
	cj30520-a.manss1.va.home.com") by vger.kernel.org with ESMTP
	id <S129035AbRBES4N>; Mon, 5 Feb 2001 13:56:13 -0500
Date: Mon, 5 Feb 2001 13:55:40 -0500
From: Matthew Harrell <mharrell@bittwiddlers.com>
To: linux-kernel@vger.rutgers.edu, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 2.4.{1,2pre1} oops in via82cxxx_audio (?)
Message-ID: <20010205135540.A19582@bittwiddlers.com>
In-Reply-To: <20010205104406.A10978@bittwiddlers.com> <200102051819.KAA31027@penguin.transmeta.com> <3A7EF0A7.343D5B7A@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3A7EF0A7.343D5B7A@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Feb 05, 2001 at 01:27:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: Ouch.  After applying the attached patch, do any of the assertions
: trigger?  (You should get a message 'Assertion failed! ...' right before
: the oops)

: +	assert (chan->sgtable != NULL);

Yep, I get this one "chan->sgtable != NULL".  I have no idea what this means
but I got it one out of the two times I tried.

-- 
  Matthew Harrell                          Every morning is the dawn of a
  Bit Twiddlers, Inc.                       new error.
  mharrell@bittwiddlers.com     
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
