Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUGQTA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUGQTA1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 15:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUGQTA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 15:00:27 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:19082 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261300AbUGQTAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 15:00:16 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.8-rc1: Possible SCSI-related problem on dual Opteron w/ NUMA
Date: Sat, 17 Jul 2004 21:09:38 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200407171826.03709.rjwysocki@sisk.pl> <20040717181240.GA67332@muc.de>
In-Reply-To: <20040717181240.GA67332@muc.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ylX+AEcB8h0UiBl"
Message-Id: <200407172109.38088.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ylX+AEcB8h0UiBl
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 17 of July 2004 20:12, Andi Kleen wrote:
> On Sat, Jul 17, 2004 at 06:26:03PM +0200, R. J. Wysocki wrote:
> > I got this on a dual Opteron system on 2.6.8-rc1 with the latest x86-64
> > patchset from Andi:
>
> Does it happen with x86_64-2.6.8-1 too ?

It did not happen when I was running that kernel, but I had only run it for a 
couple of times.  It generally does not happen with this one either.  It's 
happened only once and I reported it immediately.  But ...

... I saw something very similar on 2.6.7-rc1 and I'm now looking at the log 
(attached - it's partially corrupted, because /var was on /dev/sdb5 that 
failed too).  The hardware configuration was similar to the current one, 
AFAIR.

Well, it looks like the whole SCSI bus sometimes goes south for some reason 
and it may very well be a hardware problem that manifests itself in such a 
(strange?) way.  Or not.  Anyway, it certainly had not happened on this 
hardware _before_ 2.6.7-rc1.

I have no idea what to do to make it happen again (suggestions welcome).

rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
--Boundary-00=_ylX+AEcB8h0UiBl
Content-Type: application/x-gzip;
  name="2.6.7-rc1.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="2.6.7-rc1.log.gz"

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
4ih8+Om/tOmnfUmeAAA=

--Boundary-00=_ylX+AEcB8h0UiBl--

