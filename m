Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOEmH>; Tue, 14 Nov 2000 23:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKOEl5>; Tue, 14 Nov 2000 23:41:57 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:17653 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S129045AbQKOElx>; Tue, 14 Nov 2000 23:41:53 -0500
To: svein-olav.bjerkeset@bravida.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM problem(?) in 2.2.17
In-Reply-To: <AF6FFF5F50E4D311B45A00A0245738C90FFC36@BDR-OSL-24-208>
From: Camm Maguire <camm@enhanced.com>
Date: 14 Nov 2000 23:11:39 -0500
In-Reply-To: svein-olav.bjerkeset@bravida.no's message of "Tue, 14 Nov 2000 11:43:47 +0100"
Message-ID: <54ofzhzxfo.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!  This is a known bug.  Andrea Archangeli has a "VM-global"
patch against some of the 2.2.18-pre which is reported to work.
My understanding is that there is still investigation as to whether
this patch fixes the problem in the best manner.  Should not be too
difficult to edit for 2.2.17, but I haven't done this yet.  Anyone
know of a VM-global against 2.2.17?

Take care,

svein-olav.bjerkeset@bravida.no writes:

> Hi
> 
> We have a Compaq server running RedHat Linux 6.2 with kernel 2.2.17
> Once in a while we get errors like:
> 
> Nov 13 09:18:33 www2 kernel: VM: do_try_to_free_pages failed for httpd... 
> Nov 13 09:18:43 www2 kernel: VM: do_try_to_free_pages failed for mysqld... 
> 
> The server then hangs and I have to cycle power to get it up and running
> again.
> Does anyone here know if 
>   1. this is a known problem / bug?
>   2. there is a patch available ?
>   3. the problem is described anywhere else ?
> 
> Please CC to my e-mail as I am not subscribed to this list.
> 
> 
> Regards
> Svein Olav Bjerkeset
> Systems Eng.
> Bravida Norge AS
> svein-olav.bjerkeset@bravida.no
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
