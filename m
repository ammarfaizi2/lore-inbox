Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVAXRRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVAXRRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVAXRRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:17:07 -0500
Received: from bos-gate1.raytheon.com ([199.46.198.230]:18624 "EHLO
	bos-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261283AbVAXRRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:17:05 -0500
Subject: Query on remap_pfn_range compatibility
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF3F115AC8.F271AB73-ON86256F93.005BCD86@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 24 Jan 2005 10:54:22 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/24/2005 10:59:04 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read the messages on lkml from September 2004 about the introduction of
remap_pfn_range and have a question related to coding for it. What do you
recommend for driver coding to be compatible with these functions
(remap_page_range, remap_pfn_range)?

For example, I see at least two (or three) combination I need to address:
 - 2.4 (with remap_page_range) OR 2.6.x (with remap_page_range)
 - 2.6.x-mm (with remap_pfn_range)
Is there some symbol or #ifdef value I can depend on to determine which
function I should be calling (and the value to pass in)?

Thanks.
--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

