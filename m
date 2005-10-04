Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVJDRp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVJDRp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVJDRp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:45:27 -0400
Received: from quark.didntduck.org ([69.55.226.66]:56761 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932534AbVJDRp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:45:27 -0400
Message-ID: <4342C007.6020809@didntduck.org>
Date: Tue, 04 Oct 2005 13:46:47 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 in-kernel file opening
References: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab wrote:
> Hi,
> 
> can anybody tell me why there is no sys_open() exported in kernel/ksyms.c 
> in 2.4 kernels while the sys_close() is there? And what is then the 
> preferred way of opening files from within a 2.4 kernel module?

Why do you need to open files from kernel space?  There are usually 
better alternatives like the firmware loader interface.

--
				Brian Gerst
