Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbTBFU4N>; Thu, 6 Feb 2003 15:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbTBFU4N>; Thu, 6 Feb 2003 15:56:13 -0500
Received: from poup.poupinou.org ([195.101.94.96]:44860 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267393AbTBFU4K>; Thu, 6 Feb 2003 15:56:10 -0500
Date: Thu, 6 Feb 2003 22:05:42 +0100
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Ducrot Bruno <ducrot@poupinou.org>, Pavel Machek <pavel@ucw.cz>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Message-ID: <20030206210542.GW1205@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com> <20030204221003.GA250@elf.ucw.cz> <1044477704.1648.19.camel@laptop-linux.cunninghams> <20030206101645.GO1205@poup.poupinou.org> <1044560486.1700.13.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044560486.1700.13.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 08:41:27AM +1300, Nigel Cunningham wrote:
> On Thu, 2003-02-06 at 23:16, Ducrot Bruno wrote:
> > On Thu, Feb 06, 2003 at 09:41:44AM +1300, Nigel Cunningham wrote:
> > > Whether its slower depends on the hardware; on my 128MB Celeron 933
> > > laptop (17MB/s HDD), I can write an image of about 120MB, reboot and get
> > > back up and running in around a minute and a half. That's about the same
> > > as far as I remember, but has (as you say) the advantage of not still
> > > having to get things swapped back in.
> > 
> > The problem is the speed of the suspending process, not the whole suspend/resume
> > sequence,  especially in case of emergency suspending due to thermal condition,
> > etc.
> 
> Sorry. Perhaps I should have been clearer. I haven't spent a lot of time
> doing timings, but there doesn't seem to be any significant difference.
> In both versions, the amount of time varies with the amount of memory in

Ah ok.  I understand now.  S4bios is completely different from swsusp.
It's just as if we were comparing APM suspend-to-disk and swsusp (and no, S4bios
is *not* APM suspend-to-disk either).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
