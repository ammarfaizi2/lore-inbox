Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVDSKuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVDSKuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 06:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVDSKuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 06:50:10 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:8198 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261375AbVDSKuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 06:50:07 -0400
Date: Tue, 19 Apr 2005 12:50:04 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: alloc_pages and struct page *
Message-ID: <20050419105004.GA7612@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I get a struct page * from a call to alloc_pages with a non-zero
order, how do I get the struct page * of te following pages from the
same allocation in order to use them in calls to tcp_sendpage?

If there a documentation somewhere whcih would answer this kind of
questions?  Couldn't find anything pertinent in Documentation/*.

  OG.

