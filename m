Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbVJEUOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbVJEUOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVJEUOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:14:03 -0400
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:50151 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1030361AbVJEUOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:14:01 -0400
Subject: [PATCH/RFC 0/2] simple SPI controller on PXA2xx SSP port
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Wed, 05 Oct 2005 13:13:57 -0700
Message-Id: <1128543237.4871.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following this will be two reposted patches (with whitespace correctly
preserved), releasing an initial "SPI controller" implementation running
on David Brownell's "simple SPI framework" and a prototype "SPI
protocol" driver for the Cirrus Logic CS8415A S/PDIF decoder chip.  The
controller should run on any PXA2xx SSP port and has been tested on the
PXA255 NSSP port.  Complete board setup and description facilities per
the SPI framework are supported.

Your comments and suggestions encouraged!  You can e-mail me directly if
you have any question regarding running SPI controller on your board.

Thank you David for helping me make this real!

Stephen Street

"Afflicted by numerous newbie problems"

