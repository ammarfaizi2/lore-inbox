Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265210AbUFAUPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUFAUPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUFAUPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:15:36 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:4359 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265210AbUFAUOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:14:12 -0400
Date: Tue, 1 Jun 2004 13:12:41 -0700
From: Paul Jackson <pj@sgi.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.7-rc2] Add const to some scheduling functions
Message-Id: <20040601131241.3c808dc3.pj@sgi.com>
In-Reply-To: <12672.1086083724@ocs3.ocs.com.au>
References: <20040601001632.1cc185ba.akpm@osdl.org>
	<12672.1086083724@ocs3.ocs.com.au>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith wrote (of some added 'const' qualifiers):
> It can generate better code.

Later, he wrote (when asked under what circumstances he saw this):
>None, it is just good programming practice ...

So you're not saying it _does_ generate better code, but that it's
possible that it could do so, right?

In any case, the value of 'const' to me is more in documenting
the interface, and imposing compiler checked restrictions on the
implementation.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
