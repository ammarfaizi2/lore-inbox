Return-Path: <linux-kernel-owner+w=401wt.eu-S965201AbXATIJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbXATIJV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 03:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbXATIJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 03:09:20 -0500
Received: from terminus.zytor.com ([192.83.249.54]:35794 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965201AbXATIJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 03:09:19 -0500
Message-ID: <45B1CE1D.9040309@zytor.com>
Date: Sat, 20 Jan 2007 00:09:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Richard Knutsson <ricknu-0@student.ltu.se>
CC: ebiederm@xmission.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl.h: Comment out unused constants
References: <45B163E4.1040507@student.ltu.se>
In-Reply-To: <45B163E4.1040507@student.ltu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson wrote:
> Comment out unused constants in include/linux/sysctl.h.
> 
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

NAK as all hell.

This file exports an interface to userspace, and thus should be 
maintained indefinitely.

	-hpa
