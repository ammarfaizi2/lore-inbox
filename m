Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbUDMUPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 16:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUDMUPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 16:15:34 -0400
Received: from mail.tmr.com ([216.238.38.203]:36881 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263732AbUDMUPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 16:15:32 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: message queue limits
Date: Tue, 13 Apr 2004 16:16:10 -0400
Organization: TMR Associates, Inc
Message-ID: <c5hhkn$gss$1@gatekeeper.tmr.com>
References: <407A2DAC.3080802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1081887191 17308 192.168.12.100 (13 Apr 2004 20:13:11 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <407A2DAC.3080802@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Something has to change in the way message queues are created.
> Currently it is possible for an unprivileged user to exhaust all mq
> slots so that only root can create a few more.  Any other unprivileged
> user has no change to create anything.
> 
> I think it is necessary to create a per-user limit instead of a
> system-wide limit.

I think you mean "in addition to" rather than "instead of" here, one 
limit would keep one user from hogging the resource, the other would 
keep the resource from exhausting {whatever runs out first}.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
