Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVB0M5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVB0M5E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 07:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVB0M5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 07:57:04 -0500
Received: from hera.cwi.nl ([192.16.191.8]:42687 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261378AbVB0M5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 07:57:01 -0500
Date: Sun, 27 Feb 2005 13:56:56 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: remove include/sound/yss225.h
Message-ID: <20050227125654.GA15206@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file include/sound/yss225.h is unused.

It is more or less identical to sound/oss/yss225.h,
used by sound/oss/wavfront.c.

# rm include/sound/yss225.h

Andries


(Maybe this file is a remains from an attempt to consolidate
sound/oss/yss225.c and sound/isa/wavefront/wavefront_fx.c -
it is true that that code duplication should be eliminated,
but the identifiers used ("page_zero" etc.) are unsuitable
as globals anyway.)
