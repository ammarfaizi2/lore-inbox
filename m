Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVALNsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVALNsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 08:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVALNsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 08:48:12 -0500
Received: from quark.didntduck.org ([69.55.226.66]:14007 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261189AbVALNsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 08:48:10 -0500
Message-ID: <41E52A87.8080407@didntduck.org>
Date: Wed, 12 Jan 2005 08:47:51 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: selvakumar nagendran <kernelselva@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Removing a module even if use count is not zero
References: <20050112085345.88349.qmail@web60607.mail.yahoo.com>
In-Reply-To: <20050112085345.88349.qmail@web60607.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

selvakumar nagendran wrote:
> hello linux-experts,
>     I inserted my module into the running kernel that
> intercepts read system call. I am using kernel 2.4.28.
> Now, I am unable to remove it since each and every
> time, the module is used by some process. How can I
> remove the module even if the usecount is not zero?
>     Can anyone help me regarding this?
> 
> Thanks,
> selva
> 

Reboot.  If you remove it, the system will likely crash.

--
				Brian Gerst
