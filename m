Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTFFCGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 22:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbTFFCGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 22:06:11 -0400
Received: from dsl081-085-006.lax1.dsl.speakeasy.net ([64.81.85.6]:25218 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id S264396AbTFFCGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 22:06:10 -0400
Message-ID: <3EDFFA3E.9020406@tmsusa.com>
Date: Thu, 05 Jun 2003 19:19:42 -0700
From: Joe <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HELP!! REDHAT QUESTION
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joe briggs wrote:

>Please help.  I have a redhat 7.3 computer accross the country that was 
>installed using the WORKSTATION option.  I desperately need to telnet into 
>it, but with the new xinetd.d stuff, don't know how.  Can ANYBODY tell me how 
>to get the telnet deamon running on this box so that I can remotely log in?
>

First of all, if it was installed using the
workstation option, there is no remote
access, period.

That's why I always do a custom install.

If after the fact the appropriate daemons
are installed, be advised that telnet is an
incredibly poor choice, since you type
your password in the clear, and all traffic
to and from the remote host is in the clear,
begging to be snooped.

Please don't enable telnet, but use secure
shell for remote access - ssh clients are
easily and freely available, even for the
win doze pee cee platform (google for
putty.exe) -

Joe







