Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUHISGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUHISGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUHISF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:05:57 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:3004 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264953AbUHISFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:05:45 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Filip Van Raemdonck <filipvr@xs4all.be>
Subject: 2.6.8-rc3: vfat problem [was: Re: [Problem] 2.6.8-rc3: usb-storage devices are read-only (NOT related to iocharset)]
Date: Mon, 9 Aug 2004 20:15:40 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200408082157.35469.rjwysocki@sisk.pl> <200408082208.02328.rjwysocki@sisk.pl> <20040809095652.GB12667@debian>
In-Reply-To: <20040809095652.GB12667@debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408092015.40499.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 of August 2004 11:56, Filip Van Raemdonck wrote:
> On Sun, Aug 08, 2004 at 10:09:23PM +0200, R. J. Wysocki wrote:
> > On Sunday 08 of August 2004 21:57, R. J. Wysocki wrote:
> > > On 2.6.8-rc3 and 2.6.8-rc2-mm2 I get:
> > >
> > > chimera:~ # mount  -t vfat -o iocharset=iso8859-2 /dev/sdd1
> > > /media/pendrive [snip]
> > > chimera:~ # mount  -t vfat -o codepage=437 /dev/sdd1 /media/pendrive
> > > [snip]
>
> Does it work if you specify both iocharset and codepage?

Yes.  They may be contradictory, however (eg if I specify codepage=437 and 
iocharset=iso8859-2 it kind of "works", but I don't think it's OK).

Thanks,
RJW

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
