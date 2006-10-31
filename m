Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423779AbWJaSjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423779AbWJaSjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423782AbWJaSjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:39:10 -0500
Received: from smtp-out.google.com ([216.239.45.12]:46482 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423779AbWJaSjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:39:09 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=ZlYLfpKV00uQuZqC384bMn7vXQcCXAY3SmN5myF/iVwnJwQQ6MCZCZsXjNKMh4sCP
	tX0HI4S+GUHvVmFmpspmg==
Message-ID: <454797CB.7030404@google.com>
Date: Tue, 31 Oct 2006 10:36:59 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com> <20061031183319.GR27968@stusta.de>
In-Reply-To: <20061031183319.GR27968@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Oct 31, 2006 at 08:14:32AM -0800, Martin J. Bligh wrote:
> 
>>...
>>PS. I still think -Werror is a good plan. But I acknowledge that's
>>fairly extreme.
> 
> 
> Note that this would imply options like -Wno-unused-function and
> -Wno-unused-variable (unless you _really_ want to add a few thousand 
> #ifdef's to the kernel).

I don't think so. We already do this inside Google, and it works fine.
I just had about 20 stupid warnings to fix up for 2.6.18. Might depend
which gcc it was, but 4.1 seemed to work OK with that, at least.

M.
