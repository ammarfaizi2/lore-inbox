Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272300AbTHIJWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 05:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272305AbTHIJWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 05:22:05 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:51461 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S272300AbTHIJWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 05:22:02 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: cijoml@volny.cz, linux-kernel@vger.kernel.org
Subject: Re: APM working on SMP machines?
Date: Sat, 9 Aug 2003 11:21:31 +0200
User-Agent: KMail/1.5.3
References: <200308091105.27619.cijoml@volny.cz>
In-Reply-To: <200308091105.27619.cijoml@volny.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308091120.42524.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 August 2003 11:05, Michal Semler wrote:

Hi Michal,

> I would like to know when will work APM on SMP machines?
> I use Dell  workstation 400 with 2 P2 CPUs.
> When I remove one CPU APM works, when I have 2 in case APM
> doesn't work
> I can't use ACPI, because this machine doesn't support it.
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
> apm: disabled - APM is not SMP safe.
> Thanks for fixing and reply - it's very uncomfortable
> switch off computer manually :(

root@codeman:[/] # modinfo -p apm
......
smp int, description "Set this to enable APM use on an SMP platform. Use with 
caution on older systems"
......

Did you try this? (2.4.21 and above)

ciao, Marc

