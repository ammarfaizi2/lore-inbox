Return-Path: <linux-kernel-owner+w=401wt.eu-S965361AbXATUJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965361AbXATUJ3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965365AbXATUJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:09:29 -0500
Received: from [82.193.184.243] ([82.193.184.243]:58916 "EHLO
	aurora.bayour.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S965361AbXATUJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:09:28 -0500
X-Greylist: delayed 675 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jan 2007 15:09:27 EST
To: linux-kernel@vger.kernel.org
Subject: Re: Weird harddisk behaviour
X-PGP-Fingerprint: B7 92 93 0E 06 94 D6 22  98 1F 0B 5B FE 33 A1 0B
X-PGP-Key-ID: 0x788CD1A9
X-URL: http://www.bayour.com/
References: <87bqkzp0et.fsf@pumba.bayour.com>
	<20070116141959.GC476@deepthought> <87y7o2hsmm.fsf@pumba.bayour.com>
	<20070118001838.GA340@deepthought>
From: Turbo Fredriksson <turbo@bayour.com>
Organization: Bah!
X-Yow: Perfection is reached, not when there is no longer anything to add, but
Message-Id: <E1H8MLy-0002qU-00@pumba.bayour.com>
Date: Sat, 20 Jan 2007 20:58:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when there is no longer anything to take away.
               -- Antoine de Saint-Exupery
Date: Sat, 20 Jan 2007 20:58:17 +0100
In-Reply-To: <20070118001838.GA340@deepthought> (Ken Moffat's message of
 "Thu, 18 Jan 2007 00:18:38 +0000")
Message-ID: <87odotpj1i.fsf@pumba.bayour.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Quoting Ken Moffat <zarniwhoop@ntlworld.com>:

>  So, you were using a valid tool, but what you put in your original
> mail shows garbage - something like apple_partition_ma[mamama...

That's what fdisk showed me. I don't have a true UTF-8 system, so when
cutting-and-pasing between the shell and mail app, it might have been
distorted. But the output WAS weird!

> But if it isn't, somehow the data on the disk (or the data being
> read from it) is corrupt.

So how come it got corrupt? I did a 'dd if=/dev/zero of=/dev/sdb' (and
waited for the whole disk to be zeroed - took HOURS! :). Then partitioned
the disk and cut-and-pasted the output into the mail...

EVERY time I check the partition table (using mac-fdisk and not cfdisk),
that destorted output is shown. It's not distorted/corrupt if I use
cfdisk though...


Since I don't exactly know how to do all this with the tools in Linux,
I took the disk to my girlfriends WinXP and is currently using
'OnTrack EasyRecorvery Professional - ERP' to do scanns and tests of
the disk.

I tried parition and format it there to, but the format failed (no reason
why). I'm currently running the extended S.M.A.R.T. test. And there where
other tests I could do to... I'll let you know.
One weird thing though... ERP only found it as a 137Mb disk! It's supposed
to be a 400Gb...
-- 
Ft. Bragg ammonium genetic Ortega Nazi Uzi FSF Cocaine North Korea
Cuba Delta Force Qaddafi Treasury kibo Marxist
[See http://www.aclu.org/echelonwatch/index.html for more about this]
[Or http://www.europarl.eu.int/tempcom/echelon/pdf/rapport_echelon_en.pdf]
If neither of these works, try http://www.aclu.org and search for echelon.
Note. This is a real, not fiction.
http://www.theregister.co.uk/2001/09/06/eu_releases_echelon_spying_report/
http://www.aclu.org/safefree/nsaspying/23989res20060131.html#echelon
