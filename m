Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUDLQjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 12:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUDLQjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 12:39:55 -0400
Received: from palrel13.hp.com ([156.153.255.238]:59613 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262956AbUDLQjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 12:39:54 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16506.50767.128817.828166@napali.hpl.hp.com>
Date: Mon, 12 Apr 2004 09:39:43 -0700
To: dl8bcu@dl8bcu.de
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [1/3]
In-Reply-To: <20040412075704.B5198@Marvin.DL8BCU.ampr.org>
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
	<20040412075704.B5198@Marvin.DL8BCU.ampr.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 12 Apr 2004 07:57:05 +0000, Thorsten Kranzkowski <dl8bcu@dl8bcu.de> said:

  Thorsten> Introducing PIC_TIC_RATE.

What's this meant for?  At least for IA-64, there is zero guarantee
that there will be a timer ticking at this rate.  There are some
machines where this is the case (the ones using Intel chipsets, I
believe), but it isn't true for most machines with non-Intel chipsets
(which are common).

	--david
