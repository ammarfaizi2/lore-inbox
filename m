Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWHKVdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWHKVdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWHKVdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:33:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:62090 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932225AbWHKVda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:33:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: get_swap_bio() question
Date: Fri, 11 Aug 2006 23:32:17 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608112332.18015.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking at get_swap_bio() in mm/page_io.c and wonder why the result of
map_swap_page() in there is multiplied by (PAGE_SIZE >> 9).  Is it the block
size of 512 B hardcoded?  And if so, is that actually right (I mean, aren't there
any block devices with different block sizes)?

Rafael
