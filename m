Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946388AbWJ0LFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946388AbWJ0LFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946389AbWJ0LFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:05:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:31074 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946388AbWJ0LFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:05:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=oJAzVtitQTpRWZzHpJsPPD9v5rItLB8eKtcjA/I0bK8mWiA8PhC8gzv7btre2dv75C3ib33m8xvjrp0ahZPYAcacf978aFF+qJ0KTCI4R5P0dY5oa0lhFDYKv44lvg029N1smTuVXOlVZNQmEULTLXcy9x2PrGGxxG9/I2JlPrk=
Message-ID: <4541E7F6.40504@gmail.com>
Date: Fri, 27 Oct 2006 13:05:03 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to run an a.out file in a kernel module
References: <20061027101611.67643.qmail@web27406.mail.ukl.yahoo.com>
In-Reply-To: <20061027101611.67643.qmail@web27406.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ranjith kumar wrote:
> Hi,
> 
>           How to run an a.out file in a kernel module
>              I tried to include
>                                     system("./a.out");
>      in the C file. But I got compilation errors.

And what exactly do you want kernel to do?
If you want to create a process, see module loading procedure from kernel (i.e.
calling modprobe) -- request_module function or calling 'init=' program --
run_init_process.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
