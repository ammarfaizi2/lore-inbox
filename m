Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbTFQWGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbTFQWGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:06:05 -0400
Received: from palrel10.hp.com ([156.153.255.245]:30608 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264948AbTFQWGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:06:03 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16111.37901.389610.100530@napali.hpl.hp.com>
Date: Tue, 17 Jun 2003 15:19:57 -0700
To: "Riley Williams" <Riley@Williams.Name>
Cc: <davidm@hpl.hp.com>, "Vojtech Pavlik" <vojtech@suse.cz>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
In-Reply-To: <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name>
References: <16110.4883.885590.597687@napali.hpl.hp.com>
	<BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 17 Jun 2003 23:11:46 +0100, "Riley Williams" <Riley@Williams.Name> said:

  Riley> [CLOCK_TICK_RATE] needs to be declared there. The only
  Riley> question is regarding the value it is defined to, and it
  Riley> would have to be somebody with better knowledge of the ia64
  Riley> than me who decides that. All I can do is to post a
  Riley> reasonable default until such decision is made.

The ia64 platform architecture does not provide for such a timer and
hence there is no reasonable value that the macro could be set to.

Thanks,

	--david
