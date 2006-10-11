Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbWJKTyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWJKTyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWJKTyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:54:43 -0400
Received: from smtp-out.google.com ([216.239.45.12]:29922 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161191AbWJKTyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:54:41 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=gruFHBKC6eanpuJ3mX30mqjHQQRKDfxa5jfohrvfhcnaEUMbUw7tME21zNXwhbPXv
	nFpu1XGmGXUe4QqkWE6bA==
Message-ID: <452D4BF0.20209@google.com>
Date: Wed, 11 Oct 2006 12:54:24 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
References: <20061010000928.9d2d519a.akpm@osdl.org>
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
>
>
>
>   
fsx seems to fail now, across several different machines.

http://test.kernel.org/functional/index.html


and drill down under "regression" on the failing ones.

eg, see end of
http://test.kernel.org/abat/54516/debug/test.log.1 (i386)
and
http://test.kernel.org/abat/54503/debug/test.log.1 (x86_64)

-rc1 is OK (as is -rc1-git7)
