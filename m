Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269879AbTGPA0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 20:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269933AbTGPA0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 20:26:51 -0400
Received: from palrel10.hp.com ([156.153.255.245]:15273 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S269879AbTGPA0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 20:26:49 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.40771.167565.322759@napali.hpl.hp.com>
Date: Tue, 15 Jul 2003 17:41:39 -0700
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: <davidm@hpl.hp.com>, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: RE: [patch] e1000 TSO parameter
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010222917D@orsmsx402.jf.intel.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010222917D@orsmsx402.jf.intel.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 15 Jul 2003 17:27:56 -0700, "Feldman, Scott" <scott.feldman@intel.com> said:

  >> TSO disabled:

  >> $ modprobe InterruptThrottleRate=0,0,0,0 TSO=0,0,0,0

  Scott> If you're trying to remove all interrupt moderation, you'll
  Scott> also want to add these:

  Scott> RxIntDelay=0,0,0,0 RxAbsIntDelay=0,0,0,0 TxIntDelay=0,0,0,0
  Scott> TxAbsIntDelay=0,0,0,0

  Scott> See the app note here for more info:
  Scott> http://www.intel.com/design/network/applnots/8254x_ap450.htm

I wasn't aware of that note.  Thanks for the pointer!

	--david
