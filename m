Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270196AbTGPLxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 07:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270460AbTGPLxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 07:53:52 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:8600 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S270196AbTGPLxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 07:53:51 -0400
Message-Id: <200307161203.OAA10931@fire.malware.de>
Date: Wed, 16 Jul 2003 14:07:49 +0200
From: malware@t-online.de (Michael Mueller)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, glibc-sc@gnu.org
Subject: Re: [2.4] Inconsistency in poll(2)
References: <200307161032.MAA09922@fire.malware.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: GF954EZ1Ye7vFj9+pe2-XvQhEjhd9jJEMKOvzQw9L02afmGAkGmowa@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote:
> The kernel is 2.4.20 (debian 2.4.20-3-686). After a short look at the
> code for sys_poll I am certain the problem is originated within the
> kernel.

I should have been more carefully about locating the source. After
trying strace, I know the kernel is not the source of the problem:

poll([{fd=0, events=POLLIN}, {fd=110, events=POLLIN, revents=POLLNVAL}],
2, -1) = 1

sorry for bothering you. I am going to file a bug for the glibc instead
now.


Michael

-- 
Linux@TekXpress
http://www-users.rwth-aachen.de/Michael.Mueller4/tekxp/tekxp.html
