Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUAHDe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 22:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUAHDeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 22:34:25 -0500
Received: from hera.kernel.org ([63.209.29.2]:48619 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263592AbUAHDeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 22:34:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Use of floating point in the kernel
Date: Wed, 07 Jan 2004 19:34:06 -0800
Organization: Zytor Communications
Message-ID: <3FFCCFAE.8090302@zytor.com>
References: <20040107235912.GA23812@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: terminus.zytor.com 1073532846 5033 66.80.2.163 (8 Jan 2004 03:34:06 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 8 Jan 2004 03:34:06 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Pietikainen wrote:
> Hi
> 
> There are a few instances of use of floating point in 2.6,
> 

Has anyone considered asking the gcc people to add an -fno-fpu (or 
-mno-fpu) option, throwing an error if any FP instructions are used?

	-hpa

