Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbTCZOWu>; Wed, 26 Mar 2003 09:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbTCZOWu>; Wed, 26 Mar 2003 09:22:50 -0500
Received: from mango.tao-group.com ([62.255.240.131]:36624 "EHLO
	mail.tao-group.com") by vger.kernel.org with ESMTP
	id <S261706AbTCZOWs>; Wed, 26 Mar 2003 09:22:48 -0500
Subject: Re: Reproducible terrible interactivity since 2.5.64bk2
From: Andrew Ebling <aebling@tao-group.com>
To: Michal Schmidt <schmidt@kn.vutbr.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E81B63B.8080608@kn.vutbr.cz>
References: <3E81945C.4010102@kn.vutbr.cz>
	 <1048687681.6345.13.camel@spinel.tao.co.uk>  <3E81B63B.8080608@kn.vutbr.cz>
Content-Type: text/plain
Organization: Tao Group
Message-Id: <1048689657.6345.24.camel@spinel.tao.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 26 Mar 2003 14:40:58 +0000
Content-Transfer-Encoding: 7bit
Comment: Checked by Tao OGEMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 14:16, Michal Schmidt wrote:
> Andrew Ebling wrote:
> > I'm seeing similar on 2.5.66; xmms pauses when doing disk intensive
> > tasks.

> This may be a different problem. My test is not very disk intensive. It 
> is more CPU intensive (bzip2 compression). The disk is only slightly 
> used when running my testing script.

I just experienced the problem very badly when tarring/bzipping hundreds
of MB of source files - almost certainly CPU bound on that occasion ;-).

I could do this on 2.4.2x with no problem.

btw. xmms is playing via ALSA, but other apps are also being starved of
CPU time - 30 second screen redraws :-/.

Andy

The contents of this e-mail and any attachments are confidential and may
be legally privileged. If you have received this e-mail and you are not
a named addressee, please inform us as soon as possible on
+44 118 901 2999 and then delete the e-mail from your system. If you are
not a named addressee you must not copy, use, disclose, distribute,
print or rely on this e-mail. Any views expressed in this e-mail or any
attachments may not necessarily reflect those of Tao's management.
Although we routinely screen for viruses, addressees should scan this
e-mail and any attachments for viruses. Tao makes no representation or
warranty as to the absence of viruses in this e-mail or any attachments.
Please note that for the protection of our business, we may monitor and
read e-mails sent to and from our server(s).
