Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267455AbUHSWEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267455AbUHSWEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUHSWEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:04:30 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:4742 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S267455AbUHSWEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:04:20 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: jmerkey@comcast.net, root@chaos.analogic.com, linux-kernel@vger.kernel.org,
       jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering
References: <081920041927.27479.4124FF1B00008D3A00006B572200751150970A059D0A0306@comcast.net>
	<20040819124211.2e4d57e4.davem@redhat.com>
From: Julien Oster <usenet-20040502@usenet.frodoid.org>
Organization: FRODOID.ORG
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	jmerkey@comcast.net, root@chaos.analogic.com,
	linux-kernel@vger.kernel.org, jmerkey@drdos.com
Date: Fri, 20 Aug 2004 00:07:00 +0200
In-Reply-To: <20040819124211.2e4d57e4.davem@redhat.com> (David S. Miller's
 message of "Thu, 19 Aug 2004 12:42:11 -0700")
Message-ID: <87llgaok8r.fsf@killer.ninja.frodoid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

Hello David,

>> jmerkey@drdos.com is blocked from posting to this list.  I have
>> verified it though smtp, so I use my comcast.net account instead.
>> David Miller **WONT** respond to emails or the other list
>> maintainers.

> Well, you're not in the by-hand SPAM filter, so it must be something else.

> ? egrep drdos /opt/mail/db/smtp-policy.spam.manual
> ? egrep jmerkey /opt/mail/db/smtp-policy.spam.manual

> What message do you get back from direct smtp tests?

My messages also won't get through if I send them directly using
postfix from my workstation (with dynamic IP). I switched to using a
smarthost and now everything seems ok.

I thought it might be spam prevention. However, the SMTP server lkml
is attached to accepted the messages perfectly and just dropped it
silentily. It really should give an error when it's preventing spam,
otherwise you might not even notice that your message got dropped.

At least one message really didn't get anywhere while the SMTP server
said that everything is fine. Or maybe it's a bug somewhere that drops
messages unintendedly? Drop me a line if you need the log entry.

However, I never suspected that I was dropped on purpose, and I still
don't think so right now.

Regards,
Julien
