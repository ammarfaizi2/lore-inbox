Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTDUXdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTDUXdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:33:45 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:35746 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262706AbTDUXdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:33:42 -0400
Date: Mon, 21 Apr 2003 19:41:20 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] Runtime memory barrier patching
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andy Kleen <ak@muc.de>
Message-ID: <200304211945_MC3-1-355A-F77D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:


> Does anybody have the preferred Intel sequence somewhere?


  These are in Intel ASM form (i.e. dest first) from the 486 manual:

 2-bytes            mov reg,reg
 3-bytes            lea reg, 0[reg]  ; 8-bit displacement

No opcodes handy, though...


------
 Chuck
