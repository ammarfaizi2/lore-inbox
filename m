Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269390AbRIBV2h>; Sun, 2 Sep 2001 17:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269412AbRIBV22>; Sun, 2 Sep 2001 17:28:28 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:7077 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S269390AbRIBV2U>;
	Sun, 2 Sep 2001 17:28:20 -0400
Date: Sun, 02 Sep 2001 22:28:34 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-ID: <1041110124.999469713@[169.254.198.40]>
In-Reply-To: <20010902211614Z16265-32383+3048@humbolt.nl.linux.org>
In-Reply-To: <20010902211614Z16265-32383+3048@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Sunday, 02 September, 2001 11:23 PM +0200 Daniel Phillips 
<phillips@bonn-fries.net> wrote:

> Reposted to include Alex's correction.  Alex, could you please check this?

Thanks, yep, including () optimisation :-)

Dear volunteer/victim: Last time I looked,
  ping -f -s5000 victimip &
  ping -f -s10000 victimip &
  ping -f -s15000 victimip &
  ping -f -s20000 victimip &
  ping -f -s25000 victimip &
  ping -f -s30000 victimip &
  ping -f -s35000 victimip &
while running something buffer intensive (bonnie etc.)
tended to do a fair job of exercizing the machine's
powers of memory fragmentation / defragmentation;
reassembly of IP fragments allocates memory GFP_ATOMIC.

--
Alex Bligh
