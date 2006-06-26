Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932984AbWFZURE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984AbWFZURE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWFZURE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:17:04 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52178 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932984AbWFZURD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:17:03 -0400
Date: Mon, 26 Jun 2006 13:17:36 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Fw: [PATCH 0/2] srcu: add RCU variant that permits read-side blocking
Message-ID: <20060626201735.GA2396@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did get a couple of indications of interest in an RCU implementation
that permits sleeping on the read side, so this series is a cleaned-up
patch set, with the ops-ization of the rcutorture infrastructure separated
out into the earlier patchset.  Passed rcutorture on i386, ppc64, and s390.

Series includes:

o	Addition of SRCU primitives and documentation.

o	Addition of SRCU operations to rcutorture.

							Thanx, Paul
