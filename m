Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVAVVIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVAVVIc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 16:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVAVU7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:59:51 -0500
Received: from [81.23.229.73] ([81.23.229.73]:5611 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S262733AbVAVUlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:41:36 -0500
From: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Organization: EduSupport BV
To: linux-kernel@vger.kernel.org
Subject: Re: negative diskspace usage
Date: Sat, 22 Jan 2005 21:41:26 +0100
User-Agent: KMail/1.6.2
References: <200501220837.j0M8bgk22582@mailout.despammed.com> <20050122100933.GM7147@wiggy.net>
In-Reply-To: <20050122100933.GM7147@wiggy.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501222141.26449.norbert-kernel@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the 101% usage is the interesting point here
You are using more diskspace than you have available. 
I missed the first mail though, so what filesystem is this and which kernel 
version?

On Saturday 22 January 2005 11:09, Wichert Akkerman wrote:
> Previously ndiamond@despammed.com wrote:
> > Wichert Akkerman wrote:
> > > After cleaning up a bit df suddenly showed interesting results:
> > >
> > > Filesystem            Size  Used Avail Use% Mounted on
> > > /dev/md4             1019M  -64Z  1.1G 101% /tmp
> > >
> > > Filesystem           1K-blocks      Used Available Use% Mounted on
> > > /dev/md4               1043168 -73786976294838127736   1068904 101%
> > > /tmp
> >
> > It looks like Windows 95's FDISK
> > command created the partitions.
>
> There is no way you can see that from the output I gave, and it is also
> incorrect.
>
> > The partition boundaries still remain where Windows 95 put them, and
> > you have overlapping partitions.
>
> fdisk does not create overlapping partitions.
>
> Wichert.

-- 
<a href="http://www.edusupport.nl">EduSupport: Linux Desktop for schools and 
small to medium business in The Netherlands and Belgium</a>
