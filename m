Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937843AbWLGAiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937843AbWLGAiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937844AbWLGAiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:38:05 -0500
Received: from terminus.zytor.com ([192.83.249.54]:45337 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937843AbWLGAiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:38:03 -0500
Message-ID: <4577624A.6010008@zytor.com>
Date: Wed, 06 Dec 2006 16:37:30 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, fastboot@lists.osdl.org
Subject: Re: [PATCH] free initrds boot option
References: <4410.1165450723@neuling.org> <20061206163021.f434f09b.akpm@osdl.org>
In-Reply-To: <20061206163021.f434f09b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> I'd have thought that an option `retain_initrd' would make more sense.
> 
> Please always update Documentation/kernel-parameters.txt when adding boot
> options.
> 

I would have to agree with this; it also seems a bit odd to me to have 
this at all (kexec provides a new kernel image, surely it also provides 
a new initrd image???)

	-hpa
