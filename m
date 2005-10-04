Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVJDW22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVJDW22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVJDW22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:28:28 -0400
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:60844 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S965017AbVJDW22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:28:28 -0400
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC 0/2] simple SPI controller implementation on PXA2xx SSP port
Date: Tue, 4 Oct 2005 15:28:17 -0700
User-Agent: KMail/1.7.1
Cc: david-b@pacbell.net, spi-devel-general@lists.sourceforge.net,
       basicmark@yahoo.com, dpervushin@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041528.17439.stephen@streetfiresound.com>
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

Following this will be two patches, releasing an initial "SPI controller" 
implementation running on David Brownell's "simple SPI framework" and a 
prototype "SPI protocol" driver for the Cirrus Logic CS8415A SPD/IF decoder 
chip.  The controller should run on any PXA2xx SSP port and has been tested on
the PXA255 NSSP port.  Complete board setup and description facilities per the
the SPI framework are supported.

Your comments and suggestions encouraged!  You can e-mail me directly if you
have any question regarding running SPI controller on your board.

Thank you David for helping me make this real!

Stephen Street



