Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUHFBAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUHFBAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 21:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHFBAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 21:00:17 -0400
Received: from hera.kernel.org ([63.209.29.2]:5315 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S268040AbUHFA7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:59:47 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Is extern inline -> static inline OK?
Date: Fri, 6 Aug 2004 00:58:43 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ceul43$sbv$1@terminus.zytor.com>
References: <4112D32B.4060900@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1091753923 29056 127.0.0.1 (6 Aug 2004 00:58:43 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 6 Aug 2004 00:58:43 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4112D32B.4060900@am.sony.com>
By author:    Tim Bird <tim.bird@am.sony.com>
In newsgroup: linux.dev.kernel
>
> Pardon my ignorance...
> 
> Under what conditions is it NOT OK to convert "extern inline"
> to "static inline"?
> 

When the code is broken if it doesn't inline.

	-hpa
