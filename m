Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSHLBMs>; Sun, 11 Aug 2002 21:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317362AbSHLBMr>; Sun, 11 Aug 2002 21:12:47 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:40959 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S317191AbSHLBMr>; Sun, 11 Aug 2002 21:12:47 -0400
X-Uptime: 10:11am  up 63 days, 4 min,  1 user,  load average: 0.00, 0.01, 0.00
X-OS: Linux hazuki 2.4.17 #5 SMP Tue Feb 19 12:06:25 JST 2002 i686 unknown
To: Andrew Rodland <arodland@noln.com>
Cc: "Michel Eyckmans (MCE)" <mce@pi.be>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31: modules don't work at all
References: <200208111241.g7BCfakl018731@jebril.pi.be>
	<20020811210314.26e9d5a9.arodland@noln.com>
X-Organization: IOS
X-Disclaimer: My opinions do not necessarily represent anything ...err those of my employer
Content-Type: text/plain; charset=US-ASCII
From: ryan.flanigan@intel.com (Flanigan, Ryan)
Date: 12 Aug 2002 10:11:14 +0900
In-Reply-To: Andrew Rodland's message of "Sun, 11 Aug 2002 21:03:14 -0400"
Message-ID: <87sn1kvq31.fsf@hazuki.jp.intel.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Rodland <arodland@noln.com> writes:

    Andrew> On Sun, 11 Aug 2002 14:41:36 +0200 "Michel Eyckmans (MCE)"
    Andrew> <mce@pi.be> wrote:

    >> After upgrading from 2.5.30 to 2.5.31, nothing related to
    >> modules works for me. Insmod, rmmod, you name it. They all
    >> cause errors along the line of: "QM_SYMBOLS: Bad Address". Any
    >> suggestions?

    Andrew> Ditto here.  Ryan: Yes, CONFIG_PREEMPT is set.

try "unsetting" it.  (same problem on the 2.5.31 kernels where i had it set)
