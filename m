Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVC1OkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVC1OkM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 09:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVC1OkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 09:40:12 -0500
Received: from terminus.zytor.com ([209.128.68.124]:53216 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261791AbVC1OkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 09:40:04 -0500
Message-ID: <424816EC.8020608@zytor.com>
Date: Mon, 28 Mar 2005 06:38:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jayalk@intworks.biz
CC: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [RFC 2.6.11.2 1/1] Add reboot fixup for gx1/cs5530a
References: <200503281415.j2SEFwg4014119@intworks.biz>
In-Reply-To: <200503281415.j2SEFwg4014119@intworks.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jayalk@intworks.biz wrote:
>  
> +#ifdef CONFIG_X86_REBOOTFIXUPS
> +extern void mach_reboot_fixups(void);
> +#endif
> +

However, it would be nice if this could go in a header file instead of 
being a "naked extern".

	-hpa
