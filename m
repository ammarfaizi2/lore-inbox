Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTFPAuk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTFPAuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:50:40 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:269 "EHLO auth22.inet.co.th")
	by vger.kernel.org with ESMTP id S263183AbTFPAuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:50:39 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Jakob Oestergaard <jakob@unthought.net>
Subject: Re: NFS io errors on transfer from system running 2.4 to system running 2.5
Date: Mon, 16 Jun 2003 08:56:37 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200306031912.53569.mflt1@micrologica.com.hk> <200306032101.27215.mflt1@micrologica.com.hk> <20030603132609.GE14947@unthought.net>
In-Reply-To: <20030603132609.GE14947@unthought.net>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306160018.49652.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 June 2003 21:26, Jakob Oestergaard wrote:
> On Tue, Jun 03, 2003 at 09:01:27PM +0800, Michael Frank wrote:
> > On Tuesday 03 June 2003 20:52, Jakob Oestergaard wrote:
> > > I always use hard,intr so that I can manually interrupt hanging jobs,
> > > but also know that they do not randomly fail just because a few packets
> > > get dropped on my network.  This seems to be the common setup, as far
> > > as I know.
> >
> > Thank you,
> >
> > I will try hard, intr
>
> no prob.
>
> Please let the list know if it solves your problem or not - I'm sure
> there are people who want to know if it doesn't, and if it does then the
> solution will be in the archives for the next to find.
>
> After all, I could be mistaken...  naaahh...   ;)
>

If have tested mounting nfs partitions mode hard,intr and transfered 
kernel bitkeeper repos between systems running combinations of recent 
2.4 and 2.5 kernels, and also did bk resync and bk resolve via the network.

It is working dependably and I won't touch soft mounting mode again ...

Regards
Michael

-- 
Powered by linux-2.5.70-mm3, compiled with gcc-2.95-3 because it's rock solid

My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Learning 2.5 kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 serial and ide drivers, ACPI, S3

The 2.5 kernel could use your usage. More info on setting up 2.5 kernel at 
http://www.codemonkey.org.uk/post-halloween-2.5.txt


