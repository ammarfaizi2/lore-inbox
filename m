Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbREHOUr>; Tue, 8 May 2001 10:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132567AbREHOUh>; Tue, 8 May 2001 10:20:37 -0400
Received: from [209.225.10.21] ([209.225.10.21]:22503 "HELO mailrelay.local")
	by vger.kernel.org with SMTP id <S132561AbREHOUX>;
	Tue, 8 May 2001 10:20:23 -0400
Message-ID: <3AF7D964.BC65EBCC@elsitio.com.ar>
Date: Tue, 08 May 2001 11:32:52 +0000
From: Federico Edelman Anaya <fedelman@elsitio.com.ar>
Reply-To: fedelman@elsitio.com.ar
Organization: El Sitio
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fs.file-max
In-Reply-To: <3AF7FDE8.9C124AA9@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan:
    Hi ...

Dan Kegel wrote:

> Federico Edelman Anaya (fedelman@elsitio.com.ar) wrote:
>
> > What can I do to test the FD limit? ... Because, the FD limit is set in
> > /proc/sys/fs/file-max, sample:
> >
> > echo "2048" > /proc/sys/fs/file-max
>
> That sets the systemwide limit to 2048.

Ok ...

>
>
> > ulimit -n 8192
>
> That sets the per-process limit (for this process
> and its children) to 2048.
>

But, my perl script could open 8192 files ... I don't understand exactly
work ... which is the limit of FD? file-max?


>
> > In this case ... the FD limit = 8192 :( ... when the limit should be
> > 2048?
>
> No, the two limits are independant (except, obviously, that
> that process will reach the systemwide fd limit before it
> exhausts its per-process fd limit).
>
> > I wrote a perl script for the test ... anybody known a "C" program for
> > test the FD limit?
>
> http://www.kegel.com/dkftpbench/#tuning
>
> - Dan

