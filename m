Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbRCWK0K>; Fri, 23 Mar 2001 05:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRCWK0B>; Fri, 23 Mar 2001 05:26:01 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:11534 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130470AbRCWKZm>; Fri, 23 Mar 2001 05:25:42 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Fri, 23 Mar 2001 10:27:13 +0000
From: quintaq@yahoo.co.uk
To: <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <Pine.LNX.4.10.10103211000370.29537-100000@master.linux-ide.org>
In-Reply-To: <20010321095533Z131410-407+1932@vger.kernel.org>
	<Pine.LNX.4.10.10103211000370.29537-100000@master.linux-ide.org>
Reply-To: <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.4.62 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010323102552Z130470-407+2890@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001 11:29:00 -0800 (PST)
Andre Hedrick <andre@linux-ide.org> wrote:

> 
> First you have the faster portion of the drive using a lame OS, so do
> not
> expect Linux to perform if you put it on the slowest portions of the
> device.
> 
Hi Andre,

Thanks for responding.  The days of the lame OS are, I hope, numbered.  That is why I am here.  Since assembling this box and getting serious about changing to linux I have got myself 95% M$-free.  I do, however, earn a good deal of my living from stuff I produce on computer, and there are some very specialised apps I need that have not been ported and which won't run under Wine.

> > On the other hand, am I correct in interpreting the bonnie output for
> > the block read (included in my earlier post), of 20937 KB/sec as
> > reasonably healthy for my DTLA (ie consistent with hdparm's 30
> MB/sec),
> > when performing more realistic tasks on the linux filesystem ?
> 
> Yes if you adjust for ZONES.
  
I knew a little about that before, and a lot more now.  Even so, I would not have thought that there would be so close a relationship between a specific zone and "/" as to account for the significantly better performance I see when running bonnie from that directory.

Can I just end with a thanks and a plea ?

The thanks is for all those on the list who have responded, on list and by private email, to my questions.  I am conscious that questions of that kind are not really what this list is for, and I came here only as a last resort.  No-one flamed me.

The plea is that you (or someone), might revise ide.txt to go into a little more detail about UDMA 100 issues, especially with regard to : specific drives and controllers - the use of CONFIG_BLK_DEV_IDE_MODES and append=idex=ataxx.  I know from private emails from people following this thread, and from other lists and newsgroups, that this would be very welcome.

Regards,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

