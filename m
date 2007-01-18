Return-Path: <linux-kernel-owner+w=401wt.eu-S932711AbXARWyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbXARWyK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbXARWyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:54:09 -0500
Received: from terminus.zytor.com ([192.83.249.54]:43913 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711AbXARWyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:54:08 -0500
Message-ID: <45AFFA85.7040000@zytor.com>
Date: Thu, 18 Jan 2007 14:53:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@openvz.org>
CC: akpm@osdl.org, devel@openvz.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] msr.c: use smp_call_function_single()
References: <20070117125935.GB6021@localhost.sw.ru>
In-Reply-To: <20070117125935.GB6021@localhost.sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> It will execute rdmsr and wrmsr only on the cpu we need.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>

This is good, but a bit incomplete; see other message recently posted to 
LKML.  Since this affects paravirtualization I want to minimize the 
number of changes.

	-hpa
