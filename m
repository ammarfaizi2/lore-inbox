Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267739AbRGQAAX>; Mon, 16 Jul 2001 20:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267740AbRGQAAN>; Mon, 16 Jul 2001 20:00:13 -0400
Received: from ns.suse.de ([213.95.15.193]:14086 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267739AbRGQAAF>;
	Mon, 16 Jul 2001 20:00:05 -0400
Date: Tue, 17 Jul 2001 02:00:08 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: "Tim R. Young" <try@lyang.net>
Cc: Ignacio Vazquez-Abrams <ignacio@openservices.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: cpu id?
In-Reply-To: <20010716163004.A1103@box.lyang.net>
Message-ID: <Pine.LNX.4.30.0107170158130.11036-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001, Tim R. Young wrote:

> Thanks for the tool.
> Do I need kernel support to read out intel processor serial number?

By default, the kernel will disable the serial number.
You need to pass the boot time parameter 'serialnumber' to
leave it enabled. You'll also need the cpuid & msr drivers
compiled (into kernel or as loadable modules)

> And how it is reported by x86info?

If it is enabled, it'll get printed out with x86info -a

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

