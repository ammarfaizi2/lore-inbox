Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbULPTSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbULPTSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbULPTQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:16:01 -0500
Received: from palrel12.hp.com ([156.153.255.237]:19179 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261985AbULPTLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:11:44 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16833.56805.348569.77624@napali.hpl.hp.com>
Date: Thu, 16 Dec 2004 11:11:33 -0800
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, davidm@hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       willy@debian.org
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
In-Reply-To: <200412161107.57457.jbarnes@engr.sgi.com>
References: <200412160850.20223.jbarnes@engr.sgi.com>
	<16833.55270.601527.754270@napali.hpl.hp.com>
	<200412161056.13019.jbarnes@engr.sgi.com>
	<200412161107.57457.jbarnes@engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 16 Dec 2004 11:07:56 -0800, Jesse Barnes <jbarnes@engr.sgi.com> said:

  Jesse> On Thursday, December 16, 2004 10:56 am, Jesse Barnes wrote:

  Jesse> Maybe this is a little better?

The ia64_pci_legacy_{read,write}() functions definitely look much
better, except I don't think you need any casts in the outX() calls.

	--david
