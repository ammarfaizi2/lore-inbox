Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132426AbRDBFOh>; Mon, 2 Apr 2001 01:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132612AbRDBFO2>; Mon, 2 Apr 2001 01:14:28 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:12975 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S132426AbRDBFOT>; Mon, 2 Apr 2001 01:14:19 -0400
Date: Sun, 1 Apr 2001 22:07:25 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Miles Lane <miles@megapathdsl.net>
cc: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <3AC7DC85.CED53440@megapathdsl.net>
Message-ID: <Pine.LNX.4.33.0104012204560.29678-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles, if the system is just sending the config info it may not be a
problem, but take the microsoft example, how do you know the bug report is
just sending info that is relevent to the system and not trying to
discover everything that you have installed in your system (in our case we
can't be looking for pirated software, but assuming that the bug report is
being sent as root how do you know that it's not sending out your password
file if it just send 'stuff' out)

David Lang

 On Sun, 1 Apr 2001, Miles Lane wrote:

> David Lang wrote:
> >
> > On Sun, 1 Apr 2001, Larry McVoy wrote:
> >
> > when generating the auto bug reports make sure that the system tells the
> > user exactly what data is being sent.
> >
> > sending a large chunk of unknown data off the machine is a big concern to
> > many people.
>
> Yeah.  This is a good point, although I can't think of info
> about a system's hardware and software configuration that would
> be particularly sensitive, other than files that contain network
> topology or encrypted passwords.  I'm sure others can come up
> with such a list.  One candidate might be the smbfs configuration
> file, since network passwords can live there, right?  tcpdump output
> might also be sensitive, but that type of info would need to get
> requested by network driver developers after the initial bug report
> anyhow.
>
> 	Miles
>

