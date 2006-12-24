Return-Path: <linux-kernel-owner+w=401wt.eu-S1751336AbWLXNnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWLXNnS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 08:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWLXNnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 08:43:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:15509 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbWLXNnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 08:43:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=O0Y7G2t8N3L9qnl0XOkQsiTavcYssrGfB8De8L7AMMCPWK3X/AivTR1yyagoVaS7T9AGPe04pt01IVP6NlGO0UyFoUAl/lqeqhsh30j+Wz1vjJfzntnjAiR3k2vW9iZHfWpKtI0qR9TVg6YvEucuIMMqMFQBSyDyFNwJaKUjJbM=
Message-ID: <458E8407.1050504@gmail.com>
Date: Sun, 24 Dec 2006 14:43:12 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       marcel@holtmann.org, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
Subject: Re: ptrace() memory corruption?
References: <20061223234305.GA1809@elf.ucw.cz>	<20061223235501.GA1740@elf.ucw.cz>	<20061224000150.GA1812@elf.ucw.cz>	<20061224000605.GA1768@elf.ucw.cz>	<20061224000753.GA1811@elf.ucw.cz>	<458DD459.2030209@gmail.com>	<458E69CB.6000107@gmail.com> <20061224042225.51a6619a.akpm@osdl.org>
In-Reply-To: <20061224042225.51a6619a.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 24 Dec 2006 12:51:16 +0059
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> [   58.674780] EFLAGS: 00010046   (2.6.20-rc1-mm1 #207)
> 
> please, test 2.6.20-rc2.  We applied a fix for this.

It's working now.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
