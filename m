Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbUCZT3s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbUCZT3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:29:48 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:37518 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264120AbUCZT3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 14:29:46 -0500
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: lkml@lpbproduction.scom
Subject: Re: 2.6.5-rc2-mm3
Date: Fri, 26 Mar 2004 20:36:47 +0100
User-Agent: KMail/1.5
References: <40631649.9070000@blueyonder.co.uk> <200403261152.52237.lkml@lpbproductions.com>
In-Reply-To: <200403261152.52237.lkml@lpbproductions.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403262036.47193.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like what I've reported as the Bug #2368 (dual Opteron).

Rafael

On Friday 26 of March 2004 19:52, Matt H. wrote:
> Same results here... Forze at ' Free unused kernel memory ". I'm using an
> Athlon 3000+ , and reiserfs..
>
> Matt H.
>
> On Thursday 25 March 2004 10:26 am, you wrote:
> > Builds OK on Athlon  XP2200+, but froze at Freeing unused kernel memory:
> > 180k freed. SysRQ-B and on reboot, it got past that poing then froze
> > solid later on. This is from boot.omsg, hope to gather more data later.
> > <6>Freeing unused kernel memory: 180k freed
> > <4>Removing [35127 37455 0x0 SD]..done
> > <4>Removing [3904 35127 0x0 SD]..done
> > <4>There were 2 uncompleted unlinks/truncates. Completed
> > <6>Adding 3823460k swap on /dev/hda2.  Priority:42 extents:1
> > <4>hdb: Speed warnings UDMA 3/4/5 is not functional.          ### THE
> > CDROM ###
> > Kernel logging (ksyslog) stopped.
> > Kernel log daemon terminating.
> > Regards
> > Sid.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Rafael J. Wysocki, Ph.D.
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
