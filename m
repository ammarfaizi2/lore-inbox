Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318858AbSHLWlO>; Mon, 12 Aug 2002 18:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318859AbSHLWlO>; Mon, 12 Aug 2002 18:41:14 -0400
Received: from kih-tnt2-du-180.220.KSP.vol.com ([209.42.180.220]:35083 "EHLO
	hapablap.dns2go.com") by vger.kernel.org with ESMTP
	id <S318858AbSHLWlN>; Mon, 12 Aug 2002 18:41:13 -0400
Date: Mon, 12 Aug 2002 17:43:50 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: actiontec PCI call waiting modem not responding with kernels 2.4.7+, 2.4.6 is ok though..
Message-ID: <20020812224350.GC25701@hapablap.dns2go.com>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Dana Lacoste <dana.lacoste@peregrine.com>,
	linux-kernel@vger.kernel.org
References: <3D5569B4.4010500@bellsouth.net> <20020811053156.GA17530@hapablap.dns2go.com> <1029158509.31368.108.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029158509.31368.108.camel@dlacoste.ottawa.loran.com>
User-Agent: Mutt/1.3.27i
X-Uptime: 15:58:32 up 10 days, 18:38,  2 users,  load average: 1.16, 1.04, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 09:21:49AM -0400, Dana Lacoste wrote:
> Another confirmed "working" report.
> 
> If you're using devfs it's easy to tell if it's tts/4 or tts/2 or
> whatever, but assuming you're not using setserial and you're using
> the right ttyS it works fine (using the actiontec and IBM versions
> of the same card, based on the lucent venus chipset, with
> 2.4.everything)

That makes for 4 working reports to 2 non-working.  Apparently, these 2
people are having a true hardware issue, not merely a configuration
problem.

Can you tell me how old your modem is?  (i.e., about how long ago you
bought it?)  My theory is that actiontec made a new revision of the
modem that has sacrificed pure 16550 UART emulation in order to expose
more of the call-waiting feature to the computer.

Additionally, even my modem occasionally ceases to work, requiring a
reboot.  When this happens, dmesg contains the message "LSR safety check
failed."

Here's to getting this figured out!
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
This concept of "wuv" confuses and infuriates us!
			-- Lrrr of Omicron Persei VIII
