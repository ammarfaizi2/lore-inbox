Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbUCJSgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbUCJSgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:36:10 -0500
Received: from sadr.equallogic.com ([66.155.203.134]:28141 "HELO
	sadr.equallogic.com") by vger.kernel.org with SMTP id S262669AbUCJSgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:36:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16463.24585.85535.682722@gargle.gargle.HOWL>
Date: Wed, 10 Mar 2004 13:35:53 -0500
From: Paul Koning <pkoning@equallogic.com>
To: aph@redhat.com
Cc: rth@twiddle.net, torvalds@osdl.org, thomas.schlichter@web.de,
       akpm@osdl.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
References: <200403090043.21043.thomas.schlichter@web.de>
	<20040308161410.49127bdf.akpm@osdl.org>
	<Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
	<200403090217.40867.thomas.schlichter@web.de>
	<Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org>
	<20040310054918.GB4068@twiddle.net>
	<Pine.LNX.4.58.0403100740120.1092@ppc970.osdl.org>
	<20040310182227.GA6647@twiddle.net>
	<16463.24215.666911.238474@cuddles.cambridge.redhat.com>
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Haley <aph@redhat.com> writes:

 Andrew> Richard Henderson writes:
 >> On Wed, Mar 10, 2004 at 07:43:10AM -0800, Linus Torvalds wrote: >
 >> Ok, let's try just stripping the "const" out of the min/max
 >> macros, and > see what complains.
 >> 
 >> I remember what complains.  You get actual errors from
 >> 
 >> const int x; int y; min(x, y);

 Andrew> Can you explain *why* we have to produce a diagnostic for
 Andrew> "const const int" by default?

 Andrew> Can't we dispatch such things to "-pedantic" ? 

I like that suggestion.

  paul

