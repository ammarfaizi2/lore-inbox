Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbUDQUWK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 16:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbUDQUWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 16:22:10 -0400
Received: from hera.kernel.org ([63.209.29.2]:11425 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264039AbUDQUWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 16:22:08 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Kernel writes to RAM it doesn't own on 2.4.24
Date: Sat, 17 Apr 2004 20:21:54 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c5s3l2$6be$1@terminus.zytor.com>
References: <200404171440.18829.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1082233314 6511 63.209.29.3 (17 Apr 2004 20:21:54 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 17 Apr 2004 20:21:54 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200404171440.18829.ross@datscreative.com.au>
By author:    Ross Dickson <ross@datscreative.com.au>
In newsgroup: linux.dev.kernel
> 
> This is all most enlightening. If I am understanding correctly then every
> device driver that the author specifies to use a "mem=" command to 
> reserve some memory for said drivers use at the upper part of physical
> memory is stuffed by design. 
> 

Yup.

	-hpa
