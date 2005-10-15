Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVJONkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVJONkL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 09:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVJONkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 09:40:11 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:56149 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751151AbVJONkJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 09:40:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dEmjgUg9T3hb6qpd07bRJwSMiXbqh56V3tp7mcJs45CON+7h+/S/p/6xMtxeMtfHwEu9HCF8ok3VnNqzlSrUUFpd23ZriFBZX/9bEWH1/EM5u2WCzE4Li55+w5CNDXz89A427wj8E9O/RwOwVLzKOsMn9Sao7w5sA7BGtyzrLtg=
Message-ID: <40f323d00510150640q1b1a996p85c9b4ff468de346@mail.gmail.com>
Date: Sat, 15 Oct 2005 15:40:08 +0200
From: Benoit Boissinot <bboissin@gmail.com>
To: Damir Perisa <damir.perisa@solnet.ch>
Subject: Re: documentation? (i learned something today ;-) )
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510151524.02123.damir.perisa@solnet.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <43505F86.1050701@perkel.com> <1129341050.23895.12.camel@mindpipe>
	 <Pine.LNX.4.64.0510150846430.25927@hermes-1.csi.cam.ac.uk>
	 <200510151524.02123.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/05, Damir Perisa <damir.perisa@solnet.ch> wrote:
> hi all,
>
> Le Saturday 15 October 2005 09:48, Anton Altaparmakov a écrit:
>  | If it has sysrq compiled in as root just do:
>  |
>  | echo s > /proc/sysrq-trigger
>  | echo u > /proc/sysre-trigger
>  | echo s > /proc/sysrq-trigger
>  | echo b > /proc/sysrq-trigger
>  |
>  | This will "sync", "umount/remount read-only", "sync", "immediate
>  | hardware reboot". Should always work...
>
> i'm impressed that i see that sysrq also works from procfs.... the
> "PrintScreen/SysRq" button on my keyboard from time to time does not work
> (old keyboard) and then it's pain hitting this key if you have to.
>
> great news that you can also pass sysrq requests using proc - i've learned
> something today... is this documented somewhere? maybe i'm bad in
> reading/finding docs but i think i'm not the only one here. can somebody
> point me to the links of docs where all this magic is specified? if not,
> i will try to start my own docs on how to use the linux kernel magic.
> mainly a collection of tricks like this and similar ones.
>
> thank you in advance + greetings,
> Damir

it is mentionned in Documentation/sysrq.txt

On all -  write a character to /proc/sysrq-trigger.  eg:

                echo t > /proc/sysrq-trigger

regards,

Benoit
