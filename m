Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267988AbRHJNZF>; Fri, 10 Aug 2001 09:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbRHJNY4>; Fri, 10 Aug 2001 09:24:56 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:45830 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267988AbRHJNYw>; Fri, 10 Aug 2001 09:24:52 -0400
Message-ID: <3B73E061.25A4655F@idb.hist.no>
Date: Fri, 10 Aug 2001 15:23:45 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-pre8 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Writes to mounted devices containing file-systems.
In-Reply-To: <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> Is it possible that Linux could decline to write to a device that
> contains mounted file-systems? OTW, don't allow raw writes to
> devices or partitions if they are mounted; writes could only
> be through the file-systems themselves.
> 
> One of my file-servers was destroyed by an in-house hacker,
> (consultant) rented by our alleged Chief Information Officer,
> to destroy Linux systems and thereby show that they can't
> be used in a "professional" environment.
[...]
> I have about 20 megabytes of logs showing the machine being
> attacked from inside our firewall.

If doing that sort of thing to a server (as opposed to some
poor test machine) is okay in your company... well consider 
"testing" the security on *all* the non-linux machines as well.  

There are so many exploits out there, including but not limited
to those funny email viruses - and you get to run them
from within the firewall!

[...]
> Microsoft FUD has convinced a lot of companies that they will
> be subjected to stockholder lawsuits and customer rejection if
> they use Linux or any of those "insecure" Unix-type machines.
> 
> In this company, they hired a "CIO" who thinks that no computers
> should have any local storage or boot capability. They must all
> boot from some secure (M$) file-server. They will not be allowed
> to have local disks and, horrors -- of course no floppy drives or
> CD-ROMS.
> 
> He doesn't care that we are in the business of making software-driven
> machines so we require access to the guts of computers and their
> operating systems.

Looks like this business is going to fail soon enough...  
Start looking for other employment - avoid the rush when
it collapses.

> Linux development needs to know about the "big lie" method of
> forcing everybody to use what big companies (or the government)
> want you to use. Think, for a minute, about what "everybody knows".
> 
> "Everybody knows" relates to something that is so commonly accepted
> that nobody bothers to check if it's true or not.
> 
> Everybody knows:
>         "global warming..."
>         "greenhouse gasses..."
>         "asbestos as a carcinogin..."
>         "etc..."
> 
> The next one will be:
> 
>         "Linux is insecure..."
> 
> So, if it is at all possible to help improve its security without
> hurting its performance very much, it's really a matter of life-or-
> death for Linux. Otherwise "they" will get us.

Now, if you want a safe machine in such a hostile environment,
consider using a read-only boot device.  I.e. a cdrom, or
a harddisk jumpered read-only after the initial configuration.
You can then boot fast, and have work files on their secure server.

Helge Hafting
