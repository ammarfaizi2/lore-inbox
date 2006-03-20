Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbWCTWFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbWCTWFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWCTWFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:05:06 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:59314 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1030541AbWCTWEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:04:47 -0500
Message-ID: <441F26FD.9090108@vc.cvut.cz>
Date: Mon, 20 Mar 2006 23:04:45 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Seth Goldberg <sethmeisterg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: KBUILD_BASENAME hoses nvidia driver / vmware build processes
References: <d1064edf0603201308v4dab8355qee1dcfc9f9b5a611@mail.gmail.com>
In-Reply-To: <d1064edf0603201308v4dab8355qee1dcfc9f9b5a611@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth Goldberg wrote:
> Hi,
> 
>    Just an FYI -- I just grabbed 2.6.16 and installed it without a
> problem.  However, when I went to rebuild the nvidia module and vmware
> modules, I discovered that the lack of a definition for
> KBUILD_BASENAME in linux/include/linux/spinlock.h cause these
> components' builds to fail.  I added a stupid workaround and was able
> to build and install these components, but I wanted to bring this to
> your attention.

For VMware either grab VMware Server beta (though I believe that it is broken 
due to '(unsigned long)' added to PAGE_OFFSET; it will be fixed in next beta), 
or grab updated modules from 
http://platan.vc.cvut.cz/ftp/pub/vmware/vmware-any-any-update98.tar.gz.
							Petr Vandrovec


