Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUCaTLD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 14:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUCaTLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 14:11:03 -0500
Received: from palrel12.hp.com ([156.153.255.237]:22414 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262109AbUCaTLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 14:11:01 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16491.6076.504437.267920@napali.hpl.hp.com>
Date: Wed, 31 Mar 2004 11:10:52 -0800
To: root@chaos.analogic.com
Cc: Alex Williamson <alex.williamson@hp.com>, davidm@hpl.hp.com,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       ulrich.windl@rz.uni-regensburg.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 on Itanium2: floating-point assist fault at ip
 400000000062ada1, isr 0000020000000008
In-Reply-To: <Pine.LNX.4.53.0403311339550.12319@chaos>
References: <406AE0D5.10359.1930261@localhost>
	<200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua>
	<16491.2184.253165.545651@napali.hpl.hp.com>
	<1080757433.2326.32.camel@patsy.fc.hp.com>
	<Pine.LNX.4.53.0403311339550.12319@chaos>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 31 Mar 2004 13:53:13 -0500 (EST), "Richard B. Johnson" <root@chaos.analogic.com> said:

  Richard> The power-on or hardware-reset default for the ix86 FPU
  Richard> is to attempt to handle div 0 errors transparently.

I must be missing something.  So far I haven't seen anything that
would suggest the FPSWA faults were due to infinities.  I'd guess that
it's much more likely that they're due to denormals.

	--david
