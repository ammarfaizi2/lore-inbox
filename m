Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTDPLLc (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 07:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTDPLLb 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 07:11:31 -0400
Received: from [212.202.223.187] ([212.202.223.187]:29568 "EHLO gw.localnet")
	by vger.kernel.org with ESMTP id S264292AbTDPLLb 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 07:11:31 -0400
Message-ID: <3E9D3D34.3030601@trash.net>
Date: Wed, 16 Apr 2003 13:23:32 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [Bug 592] New: BUG at kernel/softirq.c:105
References: <20030416120330.B7188@flint.arm.linux.org.uk>
In-Reply-To: <20030416120330.B7188@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote something about this BUG, his mail
is here: http://marc.theaimsgroup.com/?l=linux-kernel&m=104979788626334&w=2

Bye,
Patrick

Russell King wrote:

>I've been trying to trace this callpath, and have hit a dead end in
>release_dev().  It seems to go weird after there, which makes it
>difficult to audit the code path.
>
>Anyone got any ideas?
>
>I'm not too bothered about this bug since I don't look after the ppp
>or tty (line discipline) code, so I'm also looking for someone else
>to assign this to.
>  
>

