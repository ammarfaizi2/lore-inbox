Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275267AbTHMPnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275266AbTHMPmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:42:09 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:34834 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S275259AbTHMPlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:41:09 -0400
Date: Wed, 13 Aug 2003 17:41:05 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: twofish missing in ipsec kernel headers
Message-ID: <20030813154105.GA30999@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just saw that ipsec-tools did not let me use twofish as cipher, and
further grepping showed that ipsec-tools does support it, but the Linux
kernel headers (in particular <linux/pfkeyv2.h>) do not define the
necessary constant, SADB_X_EALG_TWOFISHCBC.

Please add this constant and the necessary glue code to the IPsec layer!

Felix
