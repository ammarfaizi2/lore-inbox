Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275364AbTHNSu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275360AbTHNSu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:50:58 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:22112 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S275364AbTHNSul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:50:41 -0400
Date: Thu, 14 Aug 2003 19:50:03 +0100
From: Dave Jones <davej@redhat.com>
To: dleonard@dleonard.net
Cc: Mark Watts <m.watts@eris.qinetiq.com>, linux-kernel@vger.kernel.org
Subject: Re: Via KT400 agpgart issues
Message-ID: <20030814185003.GC10901@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, dleonard@dleonard.net,
	Mark Watts <m.watts@eris.qinetiq.com>, linux-kernel@vger.kernel.org
References: <200308141025.12747.m.watts@eris.qinetiq.com> <Pine.LNX.4.31.0308141129130.4489-100000@nymph.dleonard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0308141129130.4489-100000@nymph.dleonard.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 11:53:02AM -0700, dleonard@dleonard.net wrote:
 > For my geforce3 and geforce4 I didn't notice anything odd about using the
 > KT400 chipset in spite of agpgart not fully supporting it.

KT400 has two modes of operation. If you have an AGP 2.x graphics card,
the registers are in the same place they are on earlier VIA chipsets.
If you plug in an AGP 3.x card, you have to read from alternative
registers, and some of the legacy ones change meaning.

		Dave


-- 
 Dave Jones     http://www.codemonkey.org.uk
