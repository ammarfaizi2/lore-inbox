Return-Path: <linux-kernel-owner+w=401wt.eu-S932108AbXAOX1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbXAOX1X (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 18:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbXAOX1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 18:27:23 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60051 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108AbXAOX1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 18:27:22 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 16 Jan 2007 00:27:17 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: What does this scsi error mean ?
To: Olivier Galibert <galibert@pobox.com>
cc: "Hack inc." <linux-kernel@vger.kernel.org>
In-Reply-To: <20070115171602.GA23661@dspnet.fr.eu.org>
Message-ID: <tkrat.845391bfec80a6b0@s5r6.in-berlin.de>
References: <20070115171602.GA23661@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan, Olivier Galibert wrote:
> sd 0:0:0:0: SCSI error: return code = 0x08000002
> sda: Current: sense key: Hardware Error
>     ASC=0x42 ASCQ=0x0

The Additional Sense Code means "power-on or self-test failure" FWIW.
(SPC-4 annex D)
-- 
Stefan Richter
-=====-=-=== ---= =----
http://arcgraph.de/sr/

