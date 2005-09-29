Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVI2Puc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVI2Puc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVI2Pub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:50:31 -0400
Received: from magic.adaptec.com ([216.52.22.17]:20895 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932172AbVI2Pua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:50:30 -0400
Message-ID: <433C0D30.9050901@adaptec.com>
Date: Thu, 29 Sep 2005 11:50:08 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org> <433B0374.4090100@adaptec.com> <20050928223542.GA12559@alpha.home.local> <433BFB1F.2020808@adaptec.com> <433BFEDB.6050505@pobox.com>
In-Reply-To: <433BFEDB.6050505@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 15:50:17.0271 (UTC) FILETIME=[7D05DC70:01C5C50D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/05 10:48, Jeff Garzik wrote:
> Luben Tuikov wrote:
> 
>>All the while, Linux _development_, seems to follow some kind
>>"yours/mine", "gimme that/take that" kindergarten kind of way.
>>The reason I'm saying this is that _every_ successful entity
>>(person, corporation, etc) knows that in order to _survive_
>>it needs to _quickly adapt to new things_: new technologies,
>>new trends, new fads, etc.
> 
> 
> The core problem is that a SAM-friendly path to SAS has already been 
> chosen -- transport classes -- and your driver isn't following this path.

Man you never stop do you?

I repeat again (I'll cut and paste this):

When JB's transport classes were introduced there was NO MENTIONING
of SAS.  THE REASON THEY WERE INTRODUCED INTO LINUX BY JB IS TO
ACCOMODATE MPT-based SOLUTIONS FROM TWIDDLING WITH IOCTLS!

How do I know this: simple: JB's "transport attributes" have
NOTHING to do with SAM.

They break the layering architecture for one, and are
ATTRIBUTE EXPORTING FACILITY for another.

I understand that you want to preserve your friend's
bal^w^w^wpride but, lets face it:
  I do not try to shove my solution down JB's throat.

As I've said many times: they are different due to
the *technology they represent*, which differs in
implmentation, and they can coexist!

If you can say this statement:
  "The core problem is that a SAM-friendly path to SAS
   has already been chosen -- transport classes -- and
   your driver isn't following this path."

This means that you have NO CLUE ABOUT SAS or SAM!

I certainly hope that things would improve once you
start reading specs and talking to the engineers
who designed BCM8603.  (If you are still going to
write their driver for them.)

> If we choose a new path every six months, we'll never arrive at the 
> destination.

No one is choosing a new path every six months.

And this isn't a new path for _everybody_ to follow, it is only
for LLDD who need a transport layer to drive the transport
they expose an interface to.

I'm _not_ choosing a new path.  No one is required to
"follow" this.  This is just _technology_ for LLDD who _need_
a management layer, and who _cannot_ inteface with a high
level such as SCSI Core.

> Linux today is the most successful its ever been.  This system, however 
> strange it may seem, does work.

And as you can see, Linux today is the most anal retentive as it
has ever been (e.g. SAS, reiser4, and other (revolutionary) technologies).

Remember, you can only go _down_ from the top.  So please
do not say
   "Linux is the most successful it's ever been."

It's too immature as it means that it would either go down
or that it cannot become even _more_ successful.

> The rest of the Linux-SCSI devs are trying to make it less SPI-centric. 
>   Rather than just complain, we're doing something about it.

Oh this is such a political sap, Jeff -- I cannot believe
you're actually saying this.

Who are you pleasing?  Your management?

I've been asking for movement AWAY from HCIL from early
2003, when you were writing libata, remember? Or do you
want a link to marc.10east.com?

Stop this political BS sap "we're doing something about it", please.

I suggested native scsi_target support so long ago, only to get
snuffed at.

>>Many things are left to the whim of developers whose educational
>>and technical background could be in question especially when
>>your only communication with them is via email.
> 
> Background is irrelevant.  Only results matter.  Linux is a meritocracy.

Single line statements like this with 0-content, FUD-like,
only for you to reply right away, do not _contribute_ anything.

You're just throwing sand in the eyes of managament reading this.

> Spare me your paranoia.  I've been 100% honest with you in every email 
> I've written.
> 
> You -should- change other people's code.  That's how Linux gets better.

I doubt you've ever been honest with me.*  The reason is that
you are trying to push down my throat JB's "transport classes",
all the while you're saying I'm supposed to change other people's
code?

Just see how you started this email (above).

So please, don't try to get out of any situation turning 180
degrees around.

* Well, maybe you _are_ 100% honest with me.  Maybe you really
do believe that your friend JB's "transport _attributes_" code
has anything to do with SAM.

> When I chose a better path for libata's error handling, the first step 
> in that process was changing the locking, and modifying almost every 
> $!#$@! SCSI driver in the kernel.  Rather than forever complaining about 
> an outdated SCSI layer, I stepped up and fixed things.

I flipped a card: "You'll get a promotion soon!".

What else can I reply to a self-gratifying statment like this?

Can I reply with someting like: "See my SAS stuff -- how it
truthfully represents the whole domain and gives complete
control of it over to user space? See?"

> SCSI work is speeding up.  The SCSI core has come a -long- way in the 
> past couple years.  2.6.x SCSI is light years ahead of 2.4.x SCSI.

Well, this only tell you the (bad) state of affairs of _2.4.x_ SCSI.
This does _not_ tell you the state of affairs of 2.6.x SCSI.

2.6.x SCSI is light years _behind_ SAM.

	Luben

