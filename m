Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSJTUtC>; Sun, 20 Oct 2002 16:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSJTUtB>; Sun, 20 Oct 2002 16:49:01 -0400
Received: from AMarseille-201-1-4-158.abo.wanadoo.fr ([217.128.74.158]:24688
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261286AbSJTUtA>; Sun, 20 Oct 2002 16:49:00 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Andre Hedrick" <andre@linux-ide.org>,
       "Brian Gerst" <bgerst@didntduck.org>
Cc: "Christian Borntraeger" <linux@borntraeger.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
Date: Mon, 21 Oct 2002 00:54:30 +0200
Message-Id: <20021020225430.11019@192.168.4.1>
In-Reply-To: <Pine.LNX.4.10.10210191627090.24031-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10210191627090.24031-100000@master.linux-ide.org>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Asking me to make it so you or anyone else can bypass
>copy-content-protection is out of the question.  If you do not ask the
>device to do bad things, then it will not do bad things back at you.

Andre, your argument is pointless, the right answer is indeed
what you wrote below, that is don't buy those ;) Though still,
I agree we shouldn't oops.

Also one problem here is that machines like all new macs can only
_play_ CDs by reading their audio datas via ATAPI and sending those
to the sound chip, they have no analog output on the drive and
if they had, Apple didn't wire it to the sound chip.
So on these configs, there is nothing wrong even in the US wanting
to _play_ a CD you have legally purchased...

Trying to do that shouldn't result into a kernel oops :)

So the point is that even if the drive fucks up, it should
be possible to not crash, detect the fuckup, error the read
request (at least), and eventually reset the drive if it
needs that to be put back in a sane state.

I don't know what exactly is going on at the transport level
with those so-called "copy protected" CDs though, I'm afraid
only you knows exactly what's up there ;) I could investigate,
but I have no intend spending money on a copy-protected CD :)

>If your memory is short, recall I was the only person to stand up and take
>issue about having CPRM stuffed into your harddrives by default.
>
>Make a note, DON"T BUY SONY CDRW Products. 
>
>Now if you are serious about want to fix the issue and not rant about
>issues that have no meaning because they are your opinion on how the world
>should work as it relates to hardware, then we can move on.


