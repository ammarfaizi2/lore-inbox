Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUA1TZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUA1TYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:24:45 -0500
Received: from palrel13.hp.com ([156.153.255.238]:5855 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266010AbUA1TYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:24:12 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16408.3157.336306.812481@napali.hpl.hp.com>
Date: Wed, 28 Jan 2004 11:24:05 -0800
To: Andi Kleen <ak@suse.de>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, iod00d@hp.com,
       ishii.hironobu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
In-Reply-To: <20040128195246.47a84498.ak@suse.de>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
	<20040128172004.GB5494@cup.hp.com>
	<20040128184137.616b6425.ak@suse.de>
	<16408.30.896895.980121@napali.hpl.hp.com>
	<20040128195246.47a84498.ak@suse.de>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 28 Jan 2004 19:52:46 +0100, Andi Kleen <ak@suse.de> said:

  >> I find this comment interesting.  Can you elaborate what you mean by
  >> "slightly buggy systems"?

  Andi> e.g. one bit ECC errors in memory are quite common.  And with
  Andi> ECC memory they are not really fatal.

Yet they are a good indicator that something is wrong (not performing
properly) or may be failing soon.  I don't think putting on blinders
for such problems is a good idea.  Though I agree that the question of
how to report such things without needlessly alerting Joe Clueless is
an interesting challenge.

	--david
