Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUHEQNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUHEQNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267768AbUHEQNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:13:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22216 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267766AbUHEQNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:13:30 -0400
Date: Thu, 5 Aug 2004 09:13:12 -0700
From: Paul Jackson <pj@sgi.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: pluto@pld-linux.org, linux-kernel@vger.kernel.org, spot@redhat.com,
       akpm@osdl.org
Subject: Re: Make MAX_INIT_ARGS 25
Message-Id: <20040805091312.53571e46.pj@sgi.com>
In-Reply-To: <20040805082130.354fac9f@lembas.zaitcev.lan>
References: <20040804193243.36009baa@lembas.zaitcev.lan>
	<200408050752.46409.pluto@pld-linux.org>
	<20040805082130.354fac9f@lembas.zaitcev.lan>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You should also increase the COMMAND_LINE_SIZE.

Unlike the generic settings in init/main.c of MAX_INIT_ARGS and
MAX_INIT_ENV, the setting of COMMAND_LINE_SIZE is arch-specific, and on
many arch's already set to an ample value such as 512, 896 or 1024.

If you have a specific arch for which this value is too small
for your needs, you probably need to take that up with the
maintainers of that arch code.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
