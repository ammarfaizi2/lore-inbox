Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290753AbSARRRw>; Fri, 18 Jan 2002 12:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290755AbSARRRc>; Fri, 18 Jan 2002 12:17:32 -0500
Received: from ns.suse.de ([213.95.15.193]:62738 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290753AbSARRRX>;
	Fri, 18 Jan 2002 12:17:23 -0500
Date: Fri, 18 Jan 2002 18:17:22 +0100
From: Dave Jones <davej@suse.de>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-dj2 hangs loading real time clock driver
Message-ID: <20020118181722.E3517@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Duncan Sands <duncan.sands@math.u-psud.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16RWPI-0000Ja-00@baldrick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16RWPI-0000Ja-00@baldrick>; from duncan.sands@math.u-psud.fr on Fri, Jan 18, 2002 at 11:38:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 11:38:00AM +0100, Duncan Sands wrote:
 > I decided to give 2.5.2-dj2 a whirl.  It hangs at the following point:
 > Setting the System Clock using the Hardware Clock as reference
 > Real Time Clock Driver v1.10e
 > (hangs)

 Ok, I got a repeatable similar case here, which seemed to have
 been scheduler related. Solved by updating the scheduler to Ingo's
 latest and greatest.  Give -dj3 a whirl when it comes out in a few
 hours.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
