Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271811AbTHDQ0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271889AbTHDQ0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:26:05 -0400
Received: from mail.egps.com ([38.119.130.6]:30736 "EHLO egps.com")
	by vger.kernel.org with ESMTP id S271811AbTHDQ0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:26:03 -0400
Date: Mon, 4 Aug 2003 12:26:03 -0400
From: Nachman Yaakov Ziskind <awacs@egps.com>
To: linux-kernel@vger.kernel.org
Subject: Re: DVD-RAM errors (was: DVD-RAM crashing system)
Message-ID: <20030804122603.B1157@egps.egps.com>
References: <20030803234706.A13048@egps.egps.com> <1060002004.416.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060002004.416.2.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote (on Mon, Aug 04, 2003 at 02:00:04PM +0100):
> On Llu, 2003-08-04 at 04:47, Nachman Yaakov Ziskind wrote:
> > command like 'tar cvf /dev/scd0 my-files', the machine hangs for a couple 
> > of seconds, writes nothing to DVD, and I get these errors:
> > 
> > Aug  3 13:40:08 gemach kernel: Current sd0b:00: sense key Data Protect
> > Aug  3 13:40:08 gemach kernel:  I/O error: dev 0b:00, sector 4
> > Aug  3 13:40:08 gemach kernel: SCSI cdrom error : host 2 channel 0 id 0 lun
> > 0 return code = 28000000
> 
> Your drive rejected the command.

Well, ok, but *why*? In particular, why now, when this worked under 2.14.18-4,
with the appropriate ide-scsi module? I'd been doing backups to this drive for
months. I have lots of DVD's with tar data on them. I've done restores in the
past.

To keep a long story from getting longer, is there a way out of this mess
(short of buying another drive)?

Thanks!

-- 
_________________________________________
Nachman Yaakov Ziskind, EA, LLM         awacs@egps.com
Attorney and Counselor-at-Law           http://yankel.com
Economic Group Pension Services         http://egps.com
Actuaries and Employee Benefit Consultants
