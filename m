Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKKB3U>; Fri, 10 Nov 2000 20:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129029AbQKKB3K>; Fri, 10 Nov 2000 20:29:10 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:10246 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129030AbQKKB3G>;
	Fri, 10 Nov 2000 20:29:06 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where is it written? 
In-Reply-To: Your message of "10 Nov 2000 17:10:00 -0800."
             <8ui698$c2q$1@cesium.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Nov 2000 12:28:54 +1100
Message-ID: <11198.973906134@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Nov 2000 17:10:00 -0800, 
"H. Peter Anvin" <hpa@zytor.com> wrote:
>We can mess with the ABI, but it requires a wholescale rev of the
>entire system.

AFAICT, there is nothing stopping us from redoing the kernel ABI to
pass the first few parameters between kernel functions in registers.
As long as the syscall interface is unchanged, that ABI change will
only break binary modules (care_factor == 0).  The ABI type would need
to be added to the symbol version prefix, trivial.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
