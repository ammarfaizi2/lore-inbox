Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbTFLGnf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264757AbTFLGnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:43:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:39856 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264756AbTFLGne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:43:34 -0400
Date: Thu, 12 Jun 2003 12:33:32 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patchset] Fix sign handling bugs in 2.5
Message-ID: <20030612070330.GA1146@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patchset to fix sign handling bugs.  This is based on Alan's list,
and is mostly a forward port from 2.4

This patchset is for
- sign handling bug in Decnet
- sign handling bug in epca
- sign handling bug in mpt fusion
- sign handling bug in tun
- sign handling bug in aacraid

The following in Alan's list did not need a fix since it is already taken care
of in current bk.	
- sign handling bug in mwave

Patches will follow this note. Patches compile, but are not really tested.

Thanks,
Kiran

