Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWGaS4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWGaS4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWGaS4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:56:04 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:12074 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751103AbWGaS4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:56:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=iXWVBIDgFAI2+XpjQ3WAd8umK0rm0/K58IGdPXyWq3ryJpGOkVDQniwZZmH8wsYkborBcbLJfdqu3yN5tWh5+/yAiKHsJucJ9z/n4Q+T6Ht4MIM1+PUEyU+plqbK152XzsP3w2PT7RiTgEGuPjkrrV8MW4r2eyOCPdMmQofa4jg=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Pavel Machek'" <pavel@ucw.cz>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Date: Mon, 31 Jul 2006 11:55:58 -0700
Message-ID: <005101c6b4d2$f7506210$493d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060730230757.GA1800@elf.ucw.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: Aca0LQqKGVCrEV7LS6GCVxr6TuLhmAAL5lkQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Suspend2 patch is open source. You can always take a look.
> 
> swsusp is open source. You can always take a look. And you 
> can always submit a patch.
> 
> > Moreover, if someone claims suspend2 isn't ready for merge, or the
> 
> Moreover, if someone claims swsusp is broken, they should 
> attach bugzilla id.

Pavel,

You can't blame me for not doing these things, because I am not a maintainer.
However, you are, and you defend yourself so hard for that position, so if _you_ 
don't do these things, people complain.

> As you said, you do not know what you are talking about.
>
> He claims s-t-ram is easier than s-t-disk. That means that he did not do his 
> homework, and did not check the archives on the subject.

Oh yeah? Let's check the archives:

"I seriously claim that STR _should_ be a lot simpler than suspend-to-disk, 
because it avoids all the memory management problems. The reason that 
we support suspend-to-disk but not STR is totally perverse - it's simply that
it has been easier to debug, because unlike STR, we can do a "real boot" 
into a working system, and thus we don't have the debugging problems that
the "easy" suspend/resume case has."

http://thread.gmane.org/gmane.linux.power-management.general/1884/focus=2105

Maybe it's why he didn't like the STR design you had?

Maybe I am still wrong, maybe Linus is wrong too, but you can't attack me
not doing my homework.

Hua

