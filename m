Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263931AbTDHEeF (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 00:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbTDHEeF (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 00:34:05 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:49860 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S263931AbTDHEeE (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 00:34:04 -0400
Date: Tue, 8 Apr 2003 00:42:26 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH] Wanted: a limit on kernel log buffer size
To: Randy Dunlap <rddunlap@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Message-ID: <200304080045_MC3-1-3378-3CDB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:


>Here's a [modified] patch that limits kernel log buffer size
>to 1 MB max and 4 KB min.


 That's even better.

 Maybe the kernel config system could just use multi-choice,
something like this?

   ( )   8K
   ( )  16K
   ( )  32K
   ( )  64K
   ( ) 128K
   ( ) 256K

A subset of your larger range should be enough, and this
would be less prone to user error.

--
 Chuck
 <insert witty statement here>
