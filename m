Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTJNSsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTJNSrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:47:37 -0400
Received: from nondot.cs.uiuc.edu ([128.174.245.159]:64185 "EHLO nondot.org")
	by vger.kernel.org with ESMTP id S263472AbTJNSql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:46:41 -0400
Date: Tue, 14 Oct 2003 14:02:48 -0500 (CDT)
From: Chris Lattner <sabre@nondot.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
In-Reply-To: <20031014184221.GF21740@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0310141402260.4165-100000@nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why exactly is accessing the stack below %esp always a bug?
>
> Any signal can overwrite any value stored below %esp. In kernel
> any interrupt/exception can overwrite any value stored below %esp.
> Your compiler is broken....

Ah, ok.  That makes sense.  Thanks!

-Chris

-- 
http://llvm.cs.uiuc.edu/
http://www.nondot.org/~sabre/Projects/

