Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264716AbUEEQG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264716AbUEEQG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUEEQG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:06:29 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:37021 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264716AbUEEQGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:06:14 -0400
Date: Wed, 5 May 2004 09:06:05 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-Id: <20040505090605.275a0d3a.pj@sgi.com>
In-Reply-To: <20040505013135.7689e38d.akpm@osdl.org>
References: <20040505013135.7689e38d.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't build for ia64 sn2_defconfig (probably not for numa in general).
One of Andi's patches, numa-api-vma-policy-hooks.patch, is missing four
#includes of linux/mempolicy.h.

I have posted an updated version of that patch on Andi's numa thread of a
month ago - cc'd to akpm.

With this updated patch, this configuration builds.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
