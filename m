Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWHHU3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWHHU3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWHHU3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:29:06 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:36854 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030296AbWHHU3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:29:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJ3kvEAp3ZBGlcSIiyZqtEaOs14uAxoLgQVqwgrXOoyolTqD0AgIJYc8tPhEyXW1VxFkaHmRW1Cdk0xApo5bMAj6oRaGDogbVf1DchC8D2dm0t8dLy+o4lLGgFyc4iMo/6JRXfcWkoQIkx8eJ+BwaffCg3Vf5Pi0uCcTUdv3Ug0=
Message-ID: <6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com>
Date: Tue, 8 Aug 2006 22:29:03 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 08/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> The mm snapshot broken-out-2006-08-08-00-59.tar.gz has been uploaded to
>
>    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-08-00-59.tar.gz
>
> It contains the following patches against 2.6.18-rc4:

It appears very early. 2.6.18-rc3-mm2 was fine.

DWARF2 unwinder stuck at error_code+0x39/0x40
Leftover inexact backtrace
[<c0104194>] show_stack_log_lvl+0x8c/0x97
[<c0104320>] show_registers+0x181/0x215
[<c0104576>] die+0x1c2/0x2dd
[<c0117419>] do_page_fault+ox410/0x4f3
[<c02f5271>] error_code+0x39/0x40
[<c0104194>] show_stack_log_lvl+0x8c/0x97
[<c0104320>] show_registers+0x181/0x215
[<c0104576>] die+0x1c2/0x2dd
[<c0117419>] do_page_fault+0x410/0x4f3
[<c02f5271>] error_code+0x39/0x40
[<c047b609>] start_kernel+0x224/0x3a2
[<c0100210>] 0xc0100210
Code: 00 39 .......
EIP:[<c01040ca>] show_trace_log_lvl+0x11b/0x159 SS:ESP 0068:c0479e74
<0> Kernel panic - not syncing: Attempted to kill idle task!

http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm1/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
