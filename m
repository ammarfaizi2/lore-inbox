Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTEIJcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 05:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTEIJcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 05:32:53 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:52986 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262422AbTEIJcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 05:32:52 -0400
Date: Fri, 9 May 2003 05:43:20 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Terje Malmedal <terje.malmedal@usit.uio.no>
Cc: D.A.Fedorov@inp.nsk.su, linux-kernel@vger.kernel.org
Message-ID: <200305090545_MC3-1-3816-D2A2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje wrote:

> Is there any reasonable way to be able to do modify a running kernel
> like this? I assume I can't count on the method from Phrack working
> forever...

  The Phrack method involves following int 0x80 and then looking for
an instruction in the syscall code that points to the table. (Check the
archives for pt_fix.c that I posted about a month ago.)  Note that it's
trivial to break this too; I planned to post a patch to do just that
but never got around to it...


