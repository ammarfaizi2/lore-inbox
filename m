Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265781AbUGNVRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265781AbUGNVRT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUGNVRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:17:18 -0400
Received: from palrel10.hp.com ([156.153.255.245]:19397 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265789AbUGNVOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:14:12 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16629.41505.190823.945993@napali.hpl.hp.com>
Date: Wed, 14 Jul 2004 14:14:09 -0700
To: Christoph Lameter <clameter@sgi.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       ia64 <linux-ia64@vger.kernel.org>
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the
 posix-timer functions to return higher accuracy)
In-Reply-To: <Pine.LNX.4.58.0407141323530.15874@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com>
	<1089835776.1388.216.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.58.0407141323530.15874@schroedinger.engr.sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 14 Jul 2004 13:28:39 -0700 (PDT), Christoph Lameter <clameter@sgi.com> said:

  Christoph> Right. I had it named getnstimeofday before but the
  Christoph> feeling was that the patch should not introduce a new
  Christoph> name. Any approach that would allow progress on the issue
  Christoph> would be fine with me.

Just to avoid further confusion: I wasn't objecting to the name, I was
suggesting that do_gettimeofday() should instead use timespec.

  Christoph> do_gettimeofday is used all over the linux kernel for a
  Christoph> variety of purposes and lots of code depends on the
  Christoph> presence of a timeval struct.

Which is true...

	--david
