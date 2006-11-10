Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424315AbWKJFZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424315AbWKJFZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 00:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424357AbWKJFZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 00:25:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47512 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1424315AbWKJFZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 00:25:38 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Horms" <horms@verge.net.au>, "yhlu" <yinghailu@gmail.com>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       ebiederm@xmission.com, "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Kexec with latest kernel fail
References: <5986589C150B2F49A46483AC44C7BCA49071D3@ssvlexmb2.amd.com>
Date: Thu, 09 Nov 2006 22:24:59 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA49071D3@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Thu, 9 Nov 2006 17:41:35 -0800")
Message-ID: <m164dnnaac.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> Thanks, It compiled
>
> kexec get the same error "Invalid memory segment 0x100000 - ...."

Could you post the entire message and the contents of /proc/iomem.

That is where the compare is happening so this may be a parsing
issue of /proc/iomem.

Eric

