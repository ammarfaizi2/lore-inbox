Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261551AbSJDKWB>; Fri, 4 Oct 2002 06:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261548AbSJDKWB>; Fri, 4 Oct 2002 06:22:01 -0400
Received: from mailsun.llgc.org.uk ([193.61.220.2]:8891 "EHLO
	mailsun.llgc.org.uk") by vger.kernel.org with ESMTP
	id <S261545AbSJDKV7>; Fri, 4 Oct 2002 06:21:59 -0400
Message-ID: <3D9D6C84.F1736E15@llgc.org.uk>
Date: Fri, 04 Oct 2002 11:25:08 +0100
From: Illtud Daniel <illtud.daniel@llgc.org.uk>
Organization: Llyfrgell Genedlaethol Cymru
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Effrem Norwood <enorwood@effrem.com>
CC: Kanoalani Withington <kanoa@cfht.hawaii.edu>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>, jbradford@dial.pipex.com,
       jakob@unthought.net, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RAID backup
References: <CFEAJJEGMGECBCJFLGDBCENHCEAA.enorwood@effrem.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Effrem Norwood wrote:

> In addition, HSM software costs
> something (even if you write it yourself) on top of the tape infrastructure.
> One customer of ours was quoted 40K per TB of HSM *software* alone.

I've got 25TB uncompressed of HSM here, and it's cost us (ex VAT)
roughly:

£10k for the first 1.6TB (on NT, DLT library)
£18k for the next  6.0TB (on NT, LTO library)
£45k for the next 18.0TB (on Solaris, LTO Library)

...for the software licencing alone. Plus about 10% pa. in support
costs.
You're looking at about 50-60% of the library cost for the HSM software
to manage it (tapes are another thing). Is HSM really that difficult?

It really is a racket, but it's not so much compared with the
cost of re-producing the data (mainly digitized collections).
I'd be happier about it if they were more reliable (libs and s/w).
Disk arrays, on the other hand, would cost us a fortune in
upgrading the cooling - we've had to do this once just because of
the 3-4 TB of online storage we've got, and adding huge exchangers
(and associated pipes) isn't something I want to do much of.

Oh, and having spent much of last night and this morning dealing
with multiple SCSI disk failures, and having seen about 5% of
ours fail in a year, I'm rapidly seeing the light on IDE.

-- 
Illtud Daniel                                 illtud.daniel@llgc.org.uk
Uwch Ddadansoddwr Systemau                       Senior Systems Analyst
Llyfrgell Genedlaethol Cymru                  National Library of Wales
Yn siarad drosof fy hun, nid LlGC   -  Speaking personally, not for NLW
