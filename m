Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267311AbUHIWR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUHIWR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUHIWR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:17:59 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:48578 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267311AbUHIWR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:17:56 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: "Steven E. Woolard" <tuxq@earthlink.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: VFAT/MSDOS
Date: Tue, 10 Aug 2004 00:27:55 +0200
User-Agent: KMail/1.5
References: <11497362.1092087656059.JavaMail.root@ernie.psp.pas.earthlink.net>
In-Reply-To: <11497362.1092087656059.JavaMail.root@ernie.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408100027.55463.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 of August 2004 23:40, Steven E. Woolard wrote:
> VER: 2.6.8-rc3
> Using a FAT16 file system mounted via /dev/sda1
> it cannot be written to. When attempt is made it gives the error of being a
> read-only file system.

It's known.  It appears that you have to mount the fs with _both_ the 
"iocharset" _and_ "codepage" options explicitly specified to be able to write 
to it.  Alternatively, you can remount it with "rw" explicitly specified (as 
root).

I hope that someone's working on a fix. ;-)

Greets,
RJW

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
