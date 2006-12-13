Return-Path: <linux-kernel-owner+w=401wt.eu-S932652AbWLMSbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWLMSbg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbWLMSbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:31:35 -0500
Received: from [198.186.3.68] ([198.186.3.68]:38745 "EHLO mx.pathscale.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932652AbWLMSbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:31:34 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0 of 2] Add memcpy_uncached_read,
	a memcpy that doesn't cache reads
Message-Id: <patchbomb.1166032639@eng-12.pathscale.com>
Date: Wed, 13 Dec 2006 09:57:19 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew -

Here's a suitably renamed uncached-read memcpy.  I hope the name is now
self-explanatory.

	<b
