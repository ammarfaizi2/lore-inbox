Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267482AbUHSWlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUHSWlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267484AbUHSWlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:41:12 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:12031 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267482AbUHSWkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:40:55 -0400
From: jmerkey@comcast.net
To: Julien Oster <usenet-20040502@usenet.frodoid.org>,
       "David S. Miller" <davem@redhat.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering
Date: Thu, 19 Aug 2004 22:40:54 +0000
Message-Id: <081920042240.12816.41252C76000205FA000032102200763704970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be the case.  It's just happening silently.  lkml needs to return a message to 
help folks detemrine the problem if possible.

Jeff


> "David S. Miller" <davem@redhat.com> writes:
> 
> Hello David,
> 
> >> jmerkey@drdos.com is blocked from posting to this list.  I have
> >> verified it though smtp, so I use my comcast.net account instead.
> >> David Miller **WONT** respond to emails or the other list
> >> maintainers.
> 
> > Well, you're not in the by-hand SPAM filter, so it must be something else.
> 
> > ? egrep drdos /opt/mail/db/smtp-policy.spam.manual
> > ? egrep jmerkey /opt/mail/db/smtp-policy.spam.manual
> 
> > What message do you get back from direct smtp tests?
> 
> My messages also won't get through if I send them directly using
> postfix from my workstation (with dynamic IP). I switched to using a
> smarthost and now everything seems ok.
> 
> I thought it might be spam prevention. However, the SMTP server lkml
> is attached to accepted the messages perfectly and just dropped it
> silentily. It really should give an error when it's preventing spam,
> otherwise you might not even notice that your message got dropped.
> 
> At least one message really didn't get anywhere while the SMTP server
> said that everything is fine. Or maybe it's a bug somewhere that drops
> messages unintendedly? Drop me a line if you need the log entry.
> 
> However, I never suspected that I was dropped on purpose, and I still
> don't think so right now.
> 
> Regards,
> Julien
