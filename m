Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUIIMSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUIIMSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 08:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIIMSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 08:18:45 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18801
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261474AbUIIMSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 08:18:44 -0400
Message-Id: <s1405833.064@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Thu, 09 Sep 2004 14:19:28 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: x86: cr2 contents used as faulting address for alignment fault
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could anyone point me to whatever documentation/observations served for
using (starting with 2.4.x) the contents of cr2 as the address that
caused an alignment fault? A later, appearantly never applied patch
points out that this is at least not always correct (i.e. on Athlons),
and no official documentation suggests this would be valid at all.

Thanks, Jan
