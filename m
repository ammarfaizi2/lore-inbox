Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263951AbSITXSW>; Fri, 20 Sep 2002 19:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263963AbSITXSW>; Fri, 20 Sep 2002 19:18:22 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:51954 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S263951AbSITXSW>;
	Fri, 20 Sep 2002 19:18:22 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15755.44527.146016.975532@napali.hpl.hp.com>
Date: Fri, 20 Sep 2002 16:23:27 -0700
To: Matt Porter <porter@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can we drop early_serial_setup()?
In-Reply-To: <20020920163357.A30546@home.com>
References: <200209200459.g8K4xJcW011057@napali.hpl.hp.com>
	<20020920163357.A30546@home.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 20 Sep 2002 16:33:57 -0700, Matt Porter <porter@cox.net> said:

  Matt> serial8250_ports and serial8250_pops are not static structs
  Matt> in your tree?

It is.  The new routine (early_register_port) goes into 8250.c, so that's
fine.

	--david
