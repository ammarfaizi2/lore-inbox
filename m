Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRABSA7>; Tue, 2 Jan 2001 13:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbRABSAm>; Tue, 2 Jan 2001 13:00:42 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17167 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131326AbRABSAY>; Tue, 2 Jan 2001 13:00:24 -0500
Message-ID: <3A52100B.93CA6C87@transmeta.com>
Date: Tue, 02 Jan 2001 09:29:47 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Douglas Gilbert <dgilbert@interlog.com>
CC: linux-kernel@vger.kernel.org, hpa@zytor.com, sct@transmeta.com
Subject: Re: devices.txt inconsistency
In-Reply-To: <3A51FF83.E8B5151A@interlog.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> 
> While on this subject, the description of raw devices
> (char 162) in lk 2.4 is not consistent with current
> usage.
> 
> devices.txt contains this:
> 162 char        Raw block device interface
>                   0 = /dev/raw          Raw I/O control device
>                   1 = /dev/raw1         First raw I/O device
>                   2 = /dev/raw2         Second raw I/O device
>                     ...
> 
> but something like this would be more accurate:
> 162 char        Raw block device interface
>                   0 = /dev/rawctl       Raw I/O control device
>                   1 = /dev/raw/raw1     First raw I/O device
>                   2 = /dev/raw/raw2     Second raw I/O device
>                     ...
> 
> The raw(8) command supplied in RH 6.2 and 7.0 assumes the
> latter structure. I have already alerted sct and this
> change may be coming through in one of his patches.
> 

The latter is actually better, so I certainly don't mind.  sct, should I
change it?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
