Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVBPOyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVBPOyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 09:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVBPOyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 09:54:31 -0500
Received: from mail.gmx.de ([213.165.64.20]:42968 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262034AbVBPOwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 09:52:55 -0500
X-Authenticated: #26200865
Message-ID: <42135EAE.8030407@gmx.net>
Date: Wed, 16 Feb 2005 15:54:38 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: romano@dea.icai.upco.es
CC: Norbert Preining <preining@logic.at>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <20050216093454.GC22816@pern.dea.icai.upco.es>
In-Reply-To: <20050216093454.GC22816@pern.dea.icai.upco.es>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romano Giannetti schrieb:
> On Tue, Feb 15, 2005 at 06:08:37PM +0100, Norbert Preining wrote:
> 
>>On Die, 15 Feb 2005, Carl-Daniel Hailfinger wrote:
>>
>>>To suspend and resume properly, call the following script as root:
>>
>>Success. 
> 
> I tried with my Sony Vaio FX701. No luck. It goes S3 ok, but it will never
> come back (blank screen, HDD led fixed on). 
> 
> I am wishing to help, imply tell me what I have to do.

Please tell us about your graphics chipset, your .config, your
dmesg and the modules loaded. Then we my be able to help.


Regards,
Carl-Daniel

P.S. If anyone of you is running SUSE 9.2, try their latest
kernels from ftp.suse.com/pub/projects/kernel/kotd/i386/HEAD/
Additionally, you may have to upgrade mkinitrd and udev with
packages from ftp.suse.com/pub/projects and
ftp.suse.com/pub/people (try searching around a bit and you'll
surely find them).
I'm running a kernel from there right now and can still use
S3 without problems on my Samsung P35.
-- 
http://www.hailfinger.org/
