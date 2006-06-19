Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWFSXRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWFSXRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWFSXRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:17:12 -0400
Received: from ns.firmix.at ([62.141.48.66]:30121 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964972AbWFSXRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:17:11 -0400
Subject: Re: kernel-x64-smp-multiprocessor-time util problem
From: Bernd Petrovitsch <bernd@firmix.at>
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060619180413.qlgd1oj9etmosckg@69.222.0.225>
References: <20060619180413.qlgd1oj9etmosckg@69.222.0.225>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Tue, 20 Jun 2006 01:17:01 +0200
Message-Id: <1150759021.3043.33.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.344 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 18:04 -0500, art@usfltd.com wrote:
> on dual core amd-athlon under 64bit-smp core
> 
> kernel compilation time:
> 
> time make -j 8
> ...
> LD [M]  sound/usb/snd-usb-lib.ko
> LD [M]  sound/usb/usx2y/snd-usb-usx2y.ko
> 
> real    18m0.948s
> user    26m6.270s    ------bad
> sys     4m22.256s    ------?bad
> [xxx@localhost linux-2.6.17]$
> --- real-clock time  is ~18 min -- user and system time doubled?

How many virtual CPUs (i.e. HT is "2 CPUs") do you have in that machine?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

