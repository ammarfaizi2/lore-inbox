Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129608AbQKKLaG>; Sat, 11 Nov 2000 06:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129457AbQKKL37>; Sat, 11 Nov 2000 06:29:59 -0500
Received: from 3dyn245.com21.casema.net ([212.64.94.245]:1811 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129608AbQKKL32>;
	Sat, 11 Nov 2000 06:29:28 -0500
Date: Sat, 11 Nov 2000 13:23:21 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: (non)importance of loadaverages
Message-ID: <20001111132321.A12293@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <20001110133431.A16169@sendmail.com> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <jmerkey@timpanogas.org> <26054.973893835@euclid.cs.niu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <26054.973893835@euclid.cs.niu.edu>; from sendmail+rickert@Sendmail.ORG on Fri, Nov 10, 2000 at 04:03:55PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 04:03:55PM -0600, Neil W Rickert wrote:
> "Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:
> 
> >The problem of dropping connections on 2.4 was related to the O RefuseLA
> >settings.  The defaults  in the RedHat, Suse, and OpenLinux RPMs are
> >clearly set too low for modern Linux kernels.  You may want them cranked
> >up to 100 or something if you want sendmail to always work.  
> 
> If a modern Linux kernel requires high load average defaults, I will
> stop using Linux.

The importance people attach to loadaverages continues to amaze me. Two
systems doing the same work can have wildly different loadaverages. If I
code a big statemachine with lots of poll() interfaces, my loadaverage will
not get a lot higher then 1.

Should I forego writing a statemachine and use pthreads or fork(), the same
amount of work will keep lots of different processes busy and raise my
loadaverage wildly.

Do you now state that the second situation is somehow 'worse'?

Feel free however to stop using Linux. Or to quote the document Al refered
to 'See figure 1'.

Kind regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
