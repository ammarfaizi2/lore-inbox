Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263957AbUD0J6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbUD0J6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 05:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbUD0J6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 05:58:53 -0400
Received: from mail.gmx.de ([213.165.64.20]:15531 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263957AbUD0J6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 05:58:51 -0400
X-Authenticated: #21910825
Message-ID: <408E2ECE.9050804@gmx.net>
Date: Tue, 27 Apr 2004 11:58:38 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Gilles May <gilles@canalmusic.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <408DC0E0.7090500@gmx.net> <408DCFE9.3040407@canalmusic.com> <Pine.LNX.4.58.0404270039020.3414@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0404270039020.3414@montezuma.fsmlabs.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Tue, 27 Apr 2004, Gilles May wrote:
> 
> 
>>Carl-Daniel Hailfinger wrote:
>>
>>
>>>The attached patch blacklists all modules having "Linuxant" or "Conexant"
>>>in their author string. This may seem a bit broad, but AFAIK both
>>>companies never have released anything under the GPL and have a strong
>>>history of binary-only modules.
>>>
>>>
>>
>>Blacklisting modules?!
>>
>>Oh come on!
>>I agree the '\0' trick is not really nice, but blacklisting modules is
>>not really better. It's not a functionality that adds anything to the
>>kernel.
>>If ppl want/have to use that module let them!

If you had read the patch instead of complaining, you would have seen that
the only change is to taint the kernel for those modules.


> Then they should list themselves as proprietory, there will be no problem
> loading them in that case. No need to tell fibs.

Indeed.


Carl-Daniel
-- 
http://www.hailfinger.org/

