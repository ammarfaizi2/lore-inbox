Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266166AbUGJGg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUGJGg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUGJGg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:36:56 -0400
Received: from bigapple.newyorkcity.de ([192.76.147.50]:9344 "EHLO
	bigapple.newyorkcity.de") by vger.kernel.org with ESMTP
	id S266166AbUGJGgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:36:54 -0400
Date: Sat, 10 Jul 2004 08:36:19 +0200
From: Martin Ziegler <mz@newyorkcity.de>
To: James Pearson <james-p@moving-picture.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS no longer working ?
Message-ID: <3D8F3266FD65DD9E1EFB0E44@soho>
In-Reply-To: <40EF873A.30603@moving-picture.com>
References: <40EF873A.30603@moving-picture.com>
X-Mailer: Mulberry/3.1.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whew...i was sure that i compiled NFSD into the kernel. When looking at 
.config i recognized that it was set to be compiled as a module. That was 
the trick. Sorry for that and thanks for your help!

--On Samstag, 10. Juli 2004 07:05 +0100 James Pearson 
<james-p@moving-picture.com> wrote:

> Martin Ziegler:
>> it's mentioned in Documentation/Changes. When i try to mount i get the
>> message "mount: fs type nfsd not supported by kernel" although NFS is
>> compiled into the kernel. Perhaps there is another option which have to
>> be  enabled but i just overseen it ?
>
> Do you have CONFIG_NFSD set?
>
> James Pearson
>


