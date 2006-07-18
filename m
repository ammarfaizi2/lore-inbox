Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWGRNfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWGRNfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGRNfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:35:05 -0400
Received: from main.gmane.org ([80.91.229.2]:59550 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932196AbWGRNfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:35:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jarek Poplawski <jarkap@poczta.onet.pl>
Subject: Re: Odd build warning with 2.6.17.6
Date: Tue, 18 Jul 2006 13:10:21 +0000 (UTC)
Message-ID: <loom.20060718T145326-832@post.gmane.org>
References: <20060717180456.GA27612@bostik.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.53.205.170 (Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.8.0.4) Gecko/20060508 Firefox/1.5.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Bostrom <bostik+lkml <at> bostik.iki.fi> writes:

> 
>   Good day.
> 
>   I got the following, rather odd warning when building 2.6.17.6:
> 
>   MODPOST
> WARNING: drivers/acpi/processor.o - Section mismatch: reference to
> .init.data: from .text between 'acpi_processor_power_init' (at offset
> 0xe80) and 'acpi_safe_halt'
> 
>   No idea whether it affects anything for real, just thought it worth a
> mention. My .config is attached.
> 

Hi,

I think they had to begin sometime earlier in 2.6.17 - I've plenty of them with
every (re)make on ver. 2.6.17.4, but because it is workink I stopped to look at
them. I'm very surprised nobody answered you, as if it was something uncommon.
If I could remember well, they are not present when full kernel is built - only
when some drivers are changed and rebuild. I'll try to look at it again later.

Jarek P.


