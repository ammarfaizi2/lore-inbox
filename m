Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293101AbSBWF56>; Sat, 23 Feb 2002 00:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293102AbSBWF5s>; Sat, 23 Feb 2002 00:57:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28945 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293101AbSBWF53>;
	Sat, 23 Feb 2002 00:57:29 -0500
Message-ID: <3C772EF4.DB49876F@zip.com.au>
Date: Fri, 22 Feb 2002 21:56:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hugang <gang_hu@soul.com.cn>
CC: Justin Piszcz <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
In-Reply-To: <3C771D29.942A07C2@starband.net>,
		<3C771D29.942A07C2@starband.net> <20020223134053.4fbe25ed.gang_hu@soul.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hugang wrote:
> 
> On Fri, 22 Feb 2002 23:40:09 -0500
> Justin Piszcz <war@starband.net> wrote:
> 
> ...
> > GCC 2.95.3
> ...
> > System is 899 kB
> ...
> > GCC 3.0.4
> ...
> > System is 962 kB
> ...
> >
> Why the system size is different. Possble your use differ config.

Later versions of gcc produce larger executables, due to more aggressive
alignment of code and data.  Most of this can be turned off, but the
kernel build system isn't doing that.

-
