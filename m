Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSF0WJE>; Thu, 27 Jun 2002 18:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317002AbSF0WJD>; Thu, 27 Jun 2002 18:09:03 -0400
Received: from citron.cs.clemson.edu ([130.127.48.6]:64919 "EHLO
	cs.clemson.edu") by vger.kernel.org with ESMTP id <S316996AbSF0WH6>;
	Thu, 27 Jun 2002 18:07:58 -0400
Date: Thu, 27 Jun 2002 18:10:17 -0400 (EDT)
From: Bendi Vinaya Kumar <vbendi@cs.clemson.edu>
To: linux-kernel@vger.kernel.org
Subject: Skbuff Trimming
Message-ID: <Pine.GSO.4.44.0206271756540.727-100000@noisy.cs.clemson.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

June 27, 2002

Hi,

I have a question for anyone
who has been through the following
function,

___pskb_trim
(http://lxr.linux.no/source/net/core/skbuff.c#L739)

This function tries to trim an
skbuff off any trailing pad bytes.
It goes about doing its job, going
through "frags" array.

But, it does not do the same on
"frag_list". Why?

Thank you for your time.

Regards,
Vinaya Kumar Bendi
P.S.: Kindly CC any answers/comments
	to vbendi@cs.clemson.edu.

