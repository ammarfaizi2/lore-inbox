Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQKSOUJ>; Sun, 19 Nov 2000 09:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbQKSOTt>; Sun, 19 Nov 2000 09:19:49 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:64516 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129345AbQKSOTp>;
	Sun, 19 Nov 2000 09:19:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kraxel@bytesex.org (Gerd Knorr)
cc: linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5 
In-Reply-To: Your message of "19 Nov 2000 12:56:17 GMT."
             <slrn91fjfh.dta.kraxel@bogomips.masq.in-berlin.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Nov 2000 00:49:39 +1100
Message-ID: <7411.974641779@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 2000 12:56:17 GMT, 
kraxel@bytesex.org (Gerd Knorr) wrote:
>Some generic way to make module args available as kernel args too
>would be nice.  Or at least some simple one-liner I could put next to
>the MODULE_PARM() macro...

On my list for 2.5.  If foo is declared as MODULE_PARM in object bar
then you will be able to boot with bar.foo=27 or even foo=27 as long as
variable foo is unique amongst all objects in the kernel.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
