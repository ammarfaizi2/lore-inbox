Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbUJYT23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbUJYT23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUJYP73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:59:29 -0400
Received: from mailsc1.simcon-mt.com ([195.27.129.236]:36679 "EHLO
	mailsc1.simcon-mt.com") by vger.kernel.org with ESMTP
	id S262012AbUJYPnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:43:07 -0400
Date: Mon, 25 Oct 2004 17:46:45 +0200
From: "Andrei A. Voropaev" <av@simcon-mt.com>
To: linux-kernel@vger.kernel.org
Subject: cyclades.h in 2.6.9 use __iomem but don't include compiler.h
Message-ID: <20041025154645.GB1105@avorop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm not sure if this is a bug or a feature. But in 2.6.9 cyclades.h have
different definition for struct cyclades_card. This definition uses
__iomem attribute which is defined in linux/compiler.h. This is not
included in cyclades.h, which leads to compilation problems for
util-linux package.

Andrei
