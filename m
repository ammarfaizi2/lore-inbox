Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWG2V4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWG2V4S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 17:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWG2V4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 17:56:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:40224 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932226AbWG2V4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 17:56:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=jTgHgEFvNz/Vq9eni0Unza6cYRNeBCxJHG/lOAan6bdns8KcXXrthrcDysmTT2hGVateEQee97e2k2hmNIJe/+t9kmEGmENMo6521RASKiOhbT64D0+C1sfx1BYeZccS7CtT5/sMZ7yvWPuAAdm0EhszYlJ/0Ic6FuCccaCqSn8=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>, "'Bill Davidsen'" <davidsen@tmr.com>
Cc: "'Pavel Machek'" <pavel@ucw.cz>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Date: Sat, 29 Jul 2006 14:56:21 -0700
Message-ID: <005701c6b359$dacc6f50$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <200607292319.31935.rjw@sisk.pl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcazVX5Z5a4a5SPOR4CILSpv0S448wAAtjig
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Moreover, if the swsusp's resume doesn't work for you and 
> suspend2's resume does, this probably means that suspend2 
> contains some driver fixes that haven't been submitted for merging.

This statement worries me for several reasons.

First, I've seen repeatedly blame for "drivers". People might buy it if there was not a working suspend2. I never saw Nigal blame
drivers; instead he makes sure to provide working code. In the end, users want a working suspend, and that's what counts.

Second, if the current swsusp maintainers have genuine interest for the users (not just "it works on my machine"), I would think
they'd have taken a serious look at why suspend2 has a higher success rate. But from the above comment, you are not even sure why
that is, and could only speculate "this probably means (drivers)". I could hardly be convinced that the current maintainers have
been trying to work with Nigal to improve Linux suspend.

At last, "maintainer" is not just a title or a feeling of superiority, it's a responsibility of providing a great system to the
users. I'll just quote Linus when he was flaming suspend-to-ram a couple of months ago. Replace it with suspend-to-disk at your own
will:

"The fact that worries me is that suspend-to-ram DOES NOT WORK FOR PEOPLE. 
I have never _ever_ met a laptop or machine of mine that "just worked". 
I've always had to fix something, and people always end up having to do 
something ridiculous like unlink all modules etc.

If that isn't what worries you, you're on the wrong page."

http://article.gmane.org/gmane.linux.power-management.general/2105

Hua

