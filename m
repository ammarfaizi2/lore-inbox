Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLDX07>; Mon, 4 Dec 2000 18:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLDX0t>; Mon, 4 Dec 2000 18:26:49 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:53273 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129248AbQLDX0i>; Mon, 4 Dec 2000 18:26:38 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Boerner, Brian" <Brian_Boerner@adaptec.com>
cc: "'linux-kernel@vger.redhat.com'" <linux-kernel@vger.kernel.org>
Subject: Re: aacraid for 2.4.0 
In-Reply-To: Your message of "Mon, 04 Dec 2000 17:31:04 CDT."
             <E9EF680C48EAD311BDF400C04FA07B612D4D71@ntcexc02.ntc.adaptec.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Dec 2000 09:56:01 +1100
Message-ID: <1119.975970561@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000 17:31:04 -0500 , 
"Boerner, Brian" <Brian_Boerner@adaptec.com> wrote:
>The driver
>is generating a segmentation fault and produces and oops. I have included
>Code: 00 00 00 00 00 00 00 00 b8 00 00 00 83 ec 34 68 00 2c 82 c8 

That code looks bad.  I suspect you are using an old modutils on
current kernels.  modutils < 2.3.15 incorrectly load modules on recent
kernels, you should be running modutils 2.3.21 for 2.4 kernels.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
