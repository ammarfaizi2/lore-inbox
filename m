Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275087AbRJJIj1>; Wed, 10 Oct 2001 04:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275096AbRJJIjS>; Wed, 10 Oct 2001 04:39:18 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:13833 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S275087AbRJJIi7>; Wed, 10 Oct 2001 04:38:59 -0400
Message-ID: <3BC40913.7ED222C1@idb.hist.no>
Date: Wed, 10 Oct 2001 10:38:43 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.11-pre5 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org
Subject: Re: dynamic swap prioritizing
In-Reply-To: <3BC373A8.CD94917B@baldauf.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xuan Baldauf wrote:
> 
> Hello,
> 
> I have a linux box with 3 harddisks of different
> characteristics (size, seek time, throughput), each capable
[algorithm for changing swap priorities]
> 
> Does the linux kernel already implement such an
> optimization? Is it planned?
> 
It doesn't already.  I am not sure this is a kernel thing
either.  Changing swap priorities could be done by userspace
programs if there were a syscall or /proc interface
for it.  

You could then have a script changing priorities when you start your
database for example.  Or a daemon making changes based on 
statistics.

Helge Hafting
