Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286708AbSACMK2>; Thu, 3 Jan 2002 07:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286815AbSACMKT>; Thu, 3 Jan 2002 07:10:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57866 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286771AbSACMKJ>;
	Thu, 3 Jan 2002 07:10:09 -0500
Date: Thu, 3 Jan 2002 13:09:41 +0100
From: Jens Axboe <axboe@suse.de>
To: R.Oehler@GDImbH.com
Cc: Scsi <linux-scsi@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.17 crashes on SCSI-errors
Message-ID: <20020103130941.B1027@suse.de>
In-Reply-To: <XFMail.20020103130541.R.Oehler@GDImbH.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20020103130541.R.Oehler@GDImbH.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03 2002, R.Oehler@GDImbH.com wrote:
> tick login: invalid operand: 0000
> CPU:    0
> EIP:    0010:[<d0851735>]    Not tainted
> EFLAGS: 00010082
> eax: 00000042   ebx: ce3dc070   ecx: c0224080   edx: 0000270d
> esi: c009e018   edi: 00000018   ebp: c009e000   esp: c0237dd4
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c0237000)
> Stack: d0867340 00000093 cf95b9ac cfb6de00 c0237e2c 00000000 66656400 00000006 
>        cfb6de10 00000002 00000003 00000282 41000031 c0220002 ce434a00 d0851346 
>        cfb6de00 ce468ecc 00000293 ce434ab8 ce434a00 cf4f416c 00000092 d083466a 
> Call Trace: [<d0867340>] [<d0851346>] [<d083466a>] [<d0834df8>] [<d083baaf>] 
>    [<d084e880>] [<d083b10e>] [<d083b2b3>] [<d083b318>] [<d083b7a0>] [<d084cce8>] 
>    [<d08351f7>] [<d0835099>] [<c01176a2>] [<c01175d9>] [<c01173ca>] [<c0107f8d>] 
>    [<c0105150>] [<c0105150>] [<c0105173>] [<c01051d7>] [<c0105000>] [<c0105027>] 
> 
> Code: 0f 0b 83 c4 08 83 3e 00 74 13 8b 06 05 00 00 00 40 89 46 0c 
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing

Please ksymoops this oops.

-- 
Jens Axboe

