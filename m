Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTLFEA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 23:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTLFEA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 23:00:57 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:56283 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262745AbTLFEA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 23:00:56 -0500
Date: Fri, 5 Dec 2003 20:00:41 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
Message-ID: <20031206040041.GU29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Craig Bradney <cbradney@zip.com.au>,
	linux-kernel@vger.kernel.org
References: <1070672114.2759.8.camel@big.pomac.com> <1070675560.4117.9.camel@athlonxp.bradney.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070675560.4117.9.camel@athlonxp.bradney.info>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 02:52:40AM +0100, Craig Bradney wrote:
> Im not getting any NMI counts.. should I use nmi-watchdog=1?

Yes, try with nmi-watchdog=1 it should work with apic, or io-apic (or both)
enabled.
