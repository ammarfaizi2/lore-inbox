Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVKMGLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVKMGLp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 01:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVKMGLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 01:11:45 -0500
Received: from hera.kernel.org ([140.211.167.34]:64675 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750982AbVKMGLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 01:11:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] sys_punchhole()
Date: Sat, 12 Nov 2005 22:11:30 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dl6lei$aq5$1@terminus.zytor.com>
References: <1131664994.25354.36.camel@localhost.localdomain> <1131686314.2833.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1131862290 11078 127.0.0.1 (13 Nov 2005 06:11:30 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 13 Nov 2005 06:11:30 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1131686314.2833.0.camel@laptopd505.fenrus.org>
By author:    Arjan van de Ven <arjan@infradead.org>
In newsgroup: linux.dev.kernel
> On Thu, 2005-11-10 at 15:23 -0800, Badari Pulavarty wrote:
> > 
> > We discussed this in madvise(REMOVE) thread - to add support 
> > for sys_punchhole(fd, offset, len) to complete the functionality
> > (in the future).
> 
> in the past always this was said to be "really hard" in linux locking
> wise, esp. the locking with respect to truncate...
> 
> did you find a solution to this problem ?

For the sake of completeness, it should probably be stated that the
utility of such a function is pretty clear.

	-hpa
