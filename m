Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTDGIsI (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263347AbTDGIsI (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:48:08 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:48875 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263343AbTDGIsB (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 04:48:01 -0400
Date: Mon, 7 Apr 2003 04:55:27 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Wanted: a limit on kernel log buffer size
To: "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304070459_MC3-1-3358-A4AA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap:


>+#if (CONFIG_LOG_BUF_SHIFT > 20)
>+#error CONFIG_LOG_BUF_SHIFT is ridiculously large (more than 1 MB).
>+#endif


That ought to do it.  Anyone who needs more than that can just change
the source.


--
 Chuck
 I am not an octal number!
