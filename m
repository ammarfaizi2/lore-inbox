Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRKDTxN>; Sun, 4 Nov 2001 14:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275224AbRKDTxE>; Sun, 4 Nov 2001 14:53:04 -0500
Received: from unthought.net ([212.97.129.24]:59352 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S275552AbRKDTwt>;
	Sun, 4 Nov 2001 14:52:49 -0500
Date: Sun, 4 Nov 2001 20:52:48 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104205248.Q14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Dave Jones <davej@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011104202034.M14001@unthought.net> <Pine.LNX.4.30.0111042030360.15260-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0111042030360.15260-100000@Appserv.suse.de>; from davej@suse.de on Sun, Nov 04, 2001 at 08:32:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 08:32:17PM +0100, Dave Jones wrote:
> On Sun, 4 Nov 2001, Jakob Østergaard wrote:
> 
> > Now this isn't even bad - the fun begins when a resync is running, when
> > mdstat contains *progress meters* like  "[====>      ] 42%".  While being
> > nicely readable for a human, this is a parsing nightmare.  Especially
> > because stuff like this changes over time.
> 
> Any program needing to parse this would just ignore the bits between [],
> and convert the percentage to an int. Hardly a 'nightmare'.

You didn't read the output then.  The information about which disks are up
and which are failed, is put between square brackets too.  You don't want
to ignore that.

So just ignore square brackets that have "=" " " and ">" between them ?

What happens when someone decides  "[---->   ]" looks cooler ?

Or just parse the brackets with "U" "F" and "_" between them ?  What then
when someone decides that disks being resynced are marked with "R"  ?

Fuzzy matching.

Nightmare.


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
