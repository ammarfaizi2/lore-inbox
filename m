Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWEXPqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWEXPqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 11:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWEXPqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 11:46:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:17042 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932345AbWEXPqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 11:46:44 -0400
Message-ID: <44747FD0.4070605@zytor.com>
Date: Wed, 24 May 2006 08:46:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       akpm@osdl.org
Subject: Re: UML boot failure with kinit
References: <E1FipyN-0004Hz-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1FipyN-0004Hz-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> UML now compiles on 2.6.17-rc4-mm3, but it fails to boot:
> 
> [...]
> kinit: do_mounts
> kinit: name_to_dev_t(98:0) = dev(0,0)
> kinit: root_dev = dev(0,0)
> kinit: trying to mount /dev/root on /root with type ext3
> kinit: Cannot open root device dev(0,0)
> [...]
> 
> Adding 'root=ubda' to the command line cures it.
> 

Jeff Dike reported this one yesterday; it's fixed in my git tree.

Thanks!

	-hpa
