Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266690AbSLJHQ6>; Tue, 10 Dec 2002 02:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbSLJHQ5>; Tue, 10 Dec 2002 02:16:57 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:34239 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S266690AbSLJHQ4>; Tue, 10 Dec 2002 02:16:56 -0500
Date: Tue, 10 Dec 2002 07:24:40 +0000
From: Dave Jones <davej@suse.de>
To: Daniel Egger <degger@fhm.edu>
Cc: Joseph <jospehchan@yahoo.com.tw>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Message-ID: <20021210072440.GB9124@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, Daniel Egger <degger@fhm.edu>,
	Joseph <jospehchan@yahoo.com.tw>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw> <20021210055215.GA9124@suse.de> <1039504941.30881.10.camel@sonja>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039504941.30881.10.camel@sonja>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 08:22:21AM +0100, Daniel Egger wrote:

 > Interesting. I have no clue about which C3 you're talking about here but
 > a VIA Ezra has all 686 instructions including cmov and thus optimising 
 > for PPro works best for me.

Mine disagrees.

(davej@equinox:davej)$ cat /proc/cpuinfo 
processor   : 0
vendor_id   : CentaurHauls
cpu family  : 6
model       : 8
model name  : VIA C3 Ezra
stepping    : 9
cpu MHz     : 433.362
cache size  : 64 KB
fdiv_bug    : no
hlt_bug     : no
f00f_bug    : no
coma_bug    : no
fpu     : yes
fpu_exception   : yes
cpuid level : 1
wp      : yes
flags       : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips    : 865.07


        Dave
