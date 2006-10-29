Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWJ2Ma7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWJ2Ma7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 07:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWJ2Ma7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 07:30:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:27624 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932222AbWJ2Ma6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 07:30:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=V99ofh9o9Dpu4cZhUIAR2pi+SYJ8ncXowicP9AiV3fzltH5oyoMgQRnPHnme4emaksMWPMM9nRDMGl91TpSZtR8oBGFe7kc6gPpbngMnvA7jwyRRw0VEEIq7f179J1Pyz38MzA1unS6n5h5NpRGQ2eZIwv5Wd7fNcGJhwdWnrRc=
Message-ID: <45449F13.7060202@gmail.com>
Date: Sun, 29 Oct 2006 13:30:52 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to run an a.out file in a kernel module
References: <20061029111953.51907.qmail@web27408.mail.ukl.yahoo.com>
In-Reply-To: <20061029111953.51907.qmail@web27408.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do NOT top-post.

ranjith kumar wrote:
> Hi,
>     1) What is the synatx of call_usermodehelper()
> function?
>         I found out that it takes 4 arguments. But
> what values  we have to pass as argumets.
> I did searched in internet. But could not find out.
> Sorry to post this question.

grep -r call_usermodehelper linux/

> 2) How to print something  using C code such that it
> will be displayed when corresponding a.out file is
> called in a kernel module using call_usermodehelper()
> function.

By adding printk to call_usermodehelper?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
