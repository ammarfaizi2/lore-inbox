Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313217AbSC1S53>; Thu, 28 Mar 2002 13:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313219AbSC1S5J>; Thu, 28 Mar 2002 13:57:09 -0500
Received: from ns.suse.de ([213.95.15.193]:46852 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313217AbSC1S46>;
	Thu, 28 Mar 2002 13:56:58 -0500
Date: Thu, 28 Mar 2002 19:56:57 +0100
From: Dave Jones <davej@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7-dj2
Message-ID: <20020328195657.A5064@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020328124548.D23328@suse.de> <Pine.LNX.3.96.1020328120309.18285D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 12:10:36PM -0500, Bill Davidsen wrote:

 >   I haven't d/l this version (and I'm generally not even trying 2.5 at the
 > moment), but I would bet the include which defines strtok got zapped or
 > moved.

Indeed, in my tree strtok is dead, replaced with some fairly trivial
code that uses strsep. This is one of those cases that fell through the
gaps, and is worthy of adding to my 'check diff before uploading'
script.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
