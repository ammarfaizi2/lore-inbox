Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTEBIk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 04:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTEBIk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 04:40:26 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:57473 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261957AbTEBIkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 04:40:24 -0400
Date: Fri, 2 May 2003 04:50:49 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: kernel zeroing memory (was Re: Why DRM exists)
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305020452_MC3-1-3708-DBF0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott McDermott wrote:

> I would have thought that the kernel would itself zero
> memory in the case of sensitive memory contents, before
> allowing it to be used as user memory.

 There is no way to tell whether anything is sensitive or not, so it
all gets cleared.

> That's interesting...why doesn't it do that? In many cases
> the information is not sensitive.  Why incur this speed
> penalty of having to zero any memory given to user?

 That's what the 'designers' of The Beast's mainstream OS of that
era thought, and look what happened...

 And rather than admit that their bread-and-butter OS at that time
had fatal security flaws, they had the nerve to patch their apps
and release a bulletin about it!

------
 Chuck
