Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272124AbTHDSVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272125AbTHDSVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:21:20 -0400
Received: from palrel12.hp.com ([156.153.255.237]:1429 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S272124AbTHDSVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:21:05 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16174.41999.166222.406494@napali.hpl.hp.com>
Date: Mon, 4 Aug 2003 11:21:03 -0700
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
In-Reply-To: <20030804175308.GB16804@lucon.org>
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
	<20030804175308.GB16804@lucon.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 4 Aug 2003 10:53:08 -0700, "H. J. Lu" <hjl@lucon.org> said:

  HJ> Does it work on bigsur?

It should, apart from a qla1280.c glitch (see the latest ia64 diff for
the one-liner to get it to work; Jes Sorensen said he's going to
cleanup qla1280 for real).

  HJ> Does it support kernel modules?

Sure.  Kernel modules have been working for a while.  You do need
module-init-tools, of course (Debian has the necessary package in the
"unstable" tree).

	--david
