Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272289AbTHRTHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272404AbTHRTHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:07:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:22736 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272289AbTHRTHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:07:47 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 18 Aug 2003 21:07:44 +0200 (MEST)
Message-Id: <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, Dominik.Strasser@t-online.de, hch@infradead.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: headers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From garzik@gtf.org  Mon Aug 18 20:14:47 2003

    I support include/abi, or some other directory that segregates
    user<->kernel shared headers away from kernel-private headers.

    I don't see how that would be auto-generated, though.  Only created
    through lots of hard work :)

Yes, unfortunately. I started doing some of this a few times,
but it is an order of magnitude more work than one thinks at first.
Already the number of include files is very large.
And the fact that it is not just include/abi but involves the architecture
doesn't make life simpler.

No doubt we must first discuss a little bit, but not too much,
the desired directory structure and naming.
Then we must do 5% of the work, and come back to these issues.

In case people actually want to do this, I can coordinate.

In case people want to try just one file, do signal.h.

Andries




