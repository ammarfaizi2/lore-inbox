Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270440AbTGZR0H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270468AbTGZR0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:26:07 -0400
Received: from CPE000625926cd6-CM014480115318.cpe.net.cable.rogers.com ([24.157.137.42]:16512
	"EHLO daedalus.samhome.net") by vger.kernel.org with ESMTP
	id S270440AbTGZR0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:26:05 -0400
Subject: Re: Firewire (One fix worked, now getting oops)
From: Sam Bromley <sbromley@cogeco.ca>
Reply-To: sbromley@cogeco.ca
To: Ben Collins <bcollins@debian.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030726151247.GC490@phunnypharm.org>
References: <20030725161803.GJ1512@phunnypharm.org>
	 <1059155483.2525.16.camel@torrey.et.myrio.com>
	 <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org>
	 <3F217A39.2020803@rogers.com> <20030725182642.GD607@phunnypharm.org>
	 <20030725184506.GE607@phunnypharm.org> <20030725193515.GQ23196@ruvolo.net>
	 <20030725201128.GA535@phunnypharm.org>
	 <1059194478.655.49.camel@daedalus.samhome.net>
	 <20030726151247.GC490@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1059241272.757.7.camel@daedalus.samhome.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Jul 2003 13:41:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 11:12, Ben Collins wrote:
> > >>EIP; 402fd1de <__crc_param_set_short+2b6895/75bf8f>   <=====
> > 
> > >>ebx; 4039ff60 <__crc_param_set_short+359617/75bf8f>
> > >>edx; 08103a88 <__crc_ip_finish_output+23c39/133bb1>
> > >>ebp; bfffc788 <__crc_class_device_add+4dfb67/51fa16>
> > >>esp; bfffc760 <__crc_class_device_add+4dfb3f/51fa16>
> 
> This doesn't make much sense. I'm not sure what to make of it.


Well, I compiled without preempt and the problem went away.
Everything now seems to work (using Rev 1016). The oops
upon unloading ohci1394 is gone as well. Are others
having success *with* a preemptibe kernel?

Cheers,
Sam.


