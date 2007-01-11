Return-Path: <linux-kernel-owner+w=401wt.eu-S1030456AbXAKOSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbXAKOSi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbXAKOSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:18:38 -0500
Received: from neopsis.com ([213.239.204.14]:38217 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030456AbXAKOSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:18:38 -0500
Message-ID: <45A64BA1.2080403@dbservice.com>
Date: Thu, 11 Jan 2007 15:37:21 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Thunderbird 2.0b1 (X11/20061212)
MIME-Version: 1.0
To: Gert Vervoort <gert.vervoort@hccnet.nl>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oprofile broken on 2.6.19
References: <45A3FF3E.7060109@hccnet.nl> <45A525B6.5030709@dbservice.com> <45A52320.2050100@hccnet.nl>
In-Reply-To: <45A52320.2050100@hccnet.nl>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Neopsis MailScanner using ClamAV and Spaassassin
X-Neopsis-MailScanner: Found to be clean
X-Neopsis-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.366,
	required 5, autolearn=spam, AWL 0.23, BAYES_00 -2.60)
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gert Vervoort wrote:
> Tomas Carnecky wrote:
>> Gert Vervoort wrote:
>>> When I try to use oprofile on 2.6.19, it does not seem to work:
>>>
>> http://lkml.org/lkml/2006/11/22/172
>> 
> Disabling the nmi watchdog, as suggested in:
> http://marc.theaimsgroup.com/?l=oprofile-list&m=116422889324043&w=2,
> also makes oprofile work again.
>  

Oh.. that seem to be much easier then compiling a patched oprofile :)
However, I can't find any NMI option (grep NMI .config), and
CONFIG_WATCHDOG is disabled here.

tom

