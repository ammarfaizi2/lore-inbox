Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbUCVV3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbUCVV3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:29:37 -0500
Received: from mail.aei.ca ([206.123.6.14]:21472 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S263252AbUCVV3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:29:36 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1
Date: Mon, 22 Mar 2004 16:29:28 -0500
User-Agent: KMail/1.6.1
Cc: piotr@larroy.com
References: <20040316015338.39e2c48e.akpm@osdl.org> <20040322125305.GA2306@larroy.com> <20040322073327.754a5b42.akpm@osdl.org>
In-Reply-To: <20040322073327.754a5b42.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403221629.28803.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 22, 2004 10:33 am, Andrew Morton wrote:
> piotr@larroy.com (Pedro Larroy) wrote:
> >
> > Where would kernel leaked ram be accounted?
> 
> /proc/meminfo, /proc/vmstat and /proc/slabinfo.  Also sysrq-M.

I also saw problems with KDE and rc1-mm1.  Xmm showed vast
amounts of memory being allocated.  Since I updated to rc1-mm2
this has not reocurred.

Ed Tomlinson
