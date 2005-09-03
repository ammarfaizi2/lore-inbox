Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbVICAIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbVICAIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVICAIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:08:16 -0400
Received: from hera.kernel.org ([209.128.68.125]:6837 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751242AbVICAIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:08:16 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Sat, 3 Sep 2005 00:07:58 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <dfapgu$dln$1@terminus.zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1125706078 14008 127.0.0.1 (3 Sep 2005 00:07:58 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 3 Sep 2005 00:07:58 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050902235833.GA28238@codepoet.org>
By author:    Erik Andersen <andersen@codepoet.org>
In newsgroup: linux.dev.kernel
> 
> <uClibc maintainer hat on>
> That would be wonderful.
> </off>
> 
> It would be especially nice if everything targeting user space
> were to use only all the nice standard ISO C99 types as defined
> in include/stdint.h such as uint32_t and friends...
> 

Absolutely not.  This would be a POSIX namespace violation; they
*must* use double-underscore types.

	-hpa
