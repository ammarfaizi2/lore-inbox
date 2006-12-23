Return-Path: <linux-kernel-owner+w=401wt.eu-S1753342AbWLWBIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbWLWBIu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 20:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbWLWBIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 20:08:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:58034 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbWLWBIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 20:08:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=PR0WkyKUDplOqedxkBc7tmF9F97YPPbX30VmJKohvrEhYZUg0BNZX5iIKVagjoGeFNN2z4OnzYtbcYlnYMfFNQwiB8wHy94M5R4ojhlbgrYXTmDCoBATQ6kqG4SiSKzRp911rfUozLJA5lz4pYPXT/KbHcsljWYvq87gSUq6hSA=
Message-ID: <458C81B2.1060006@gmail.com>
Date: Sat, 23 Dec 2006 02:08:43 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: osv@javad.com
CC: Andrew Morton <akpm@osdl.org>,
       linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com> <87r6urket6.fsf@javad.com> <458C37BE.5000409@gmail.com>
In-Reply-To: <458C37BE.5000409@gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> osv@javad.com wrote:
>> Hi Jiri,
>>
>> I've figured out that both old and new mxser drivers have two similar
>> problems:
>>
>> 1. When there are data coming to a port, sometimes opening of the port
>>    entirely locks the box. This is quite reproducible. Any idea what's
>>    wrong and how can I help to debug it?
> 
> Please enable

BTW. Does sysrq-keys work in such situation for you? I'll appreciate if you was
able to grab sysrq-t output, when it happens.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
