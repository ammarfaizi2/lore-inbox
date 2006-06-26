Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbWFZSrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWFZSrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWFZSrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:47:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:3819 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932639AbWFZSrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:47:51 -0400
Date: Mon, 26 Jun 2006 11:48:21 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       arjan@infradead.org, ioe-lkml@rameria.de, greg@kroah.com,
       pbadari@us.ibm.com, mrmacman_g4@mac.com, hugh@veritas.com,
       vatsa@in.ibm.com
Subject: [PATCH 0/3] 2.6.17 rcutorture: add ops vector to test multiple RCUs
Message-ID: <20060626184821.GA2091@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains the following:

o	Catch-up updates to the rcutorture documentation.
o	Ops vector for rcutorture to allow it to test multiple RCU
	implementations (e.g., both call_rcu() and call_rcu_bh()
	currently in mainline).
o	Add operations to allow the _bh variant of RCU to be tested.

						Thanx, Paul
