Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUA1TsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUA1TsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:48:13 -0500
Received: from palrel12.hp.com ([156.153.255.237]:12165 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266182AbUA1TsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:48:09 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16408.4597.123125.788631@napali.hpl.hp.com>
Date: Wed, 28 Jan 2004 11:48:05 -0800
To: Andi Kleen <ak@suse.de>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, iod00d@hp.com,
       ishii.hironobu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
In-Reply-To: <20040128203915.22d84e8d.ak@suse.de>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
	<20040128172004.GB5494@cup.hp.com>
	<20040128184137.616b6425.ak@suse.de>
	<16408.30.896895.980121@napali.hpl.hp.com>
	<20040128195246.47a84498.ak@suse.de>
	<16408.3157.336306.812481@napali.hpl.hp.com>
	<20040128203915.22d84e8d.ak@suse.de>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 28 Jan 2004 20:39:15 +0100, Andi Kleen <ak@suse.de> said:

  >> Yet they are a good indicator that something is wrong (not performing
  >> properly) or may be failing soon.  I don't think putting on blinders
  >> for such problems is a good idea.  Though I agree that the question of

  Andi> Most server class hardware should log it somewhere and allow
  Andi> to read the event log in the firmware. This even works for
  Andi> unhandleable errors unlike what the OS could do.

And you'd want to reboot your server just so you can check on the soft
failure rate? ;-)

	--david
