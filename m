Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWKQUwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWKQUwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbWKQUwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:52:51 -0500
Received: from nz-out-0102.google.com ([64.233.162.195]:46418 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751850AbWKQUwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:52:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HXD+pc2vnriZ5pWCybK3wcbuYKNggZiXwjTDBd+dFC0LxPnJlLHb6a9OTzxjdznDMPJ+LKgLYlvi9RrAblV75x+R8HpSyzZeBMJK4RfVjbyp3YYgnQlvcVddlmBlbB7m8+7lj3+ExEDG9nu5fnx7N3CvMNnWo6/PBi5DAHLj9zY=
Message-ID: <8aa016e10611171252m4d77d70ei855ea78a9e1b5f83@mail.gmail.com>
Date: Sat, 18 Nov 2006 02:22:49 +0530
From: "Dhaval Giani" <dhaval.giani@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: cpufreq userspace governor does not reflect changes
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <8aa016e10611171203l4eac8e67hbfc31801a54f6a1e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <EB12A50964762B4D8111D55B764A8454E763D2@scsmsx413.amr.corp.intel.com>
	 <8aa016e10611171203l4eac8e67hbfc31801a54f6a1e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 11/18/06, Dhaval Giani <dhaval.giani@gmail.com> wrote:
> On 11/18/06, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
> >
> >
> > >-----Original Message-----
> > >From: Dhaval Giani [mailto:dhaval.giani@gmail.com]
> > >Sent: Friday, November 17, 2006 11:48 AM
> > >To: Pallipadi, Venkatesh
> > >Cc: davej@codemonkey.org.uk; linux-kernel@vger.kernel.org
> > >Subject: Re: cpufreq userspace governor does not reflect changes
> > >
> > >Hey,
> > >
> > >On 11/18/06, Pallipadi, Venkatesh
> > ><venkatesh.pallipadi@intel.com> wrote:
> > >>
> > >> /sys/devices/....../cpuX/cpufreq/scaling_cur_freq
> > >> Gives you the information about last frequency that Linux
> > >tried to set
> > >> on this CPU
> > >>
> > >> /sys/devices/....../cpuX/cpufreq/cpuinfo_cur_freq
> > >> (When supported) Gives you the information about actual
> > >frequency that
> > >> the CPU is running at.
> > >>
> > >> Zero frequency value below is certainly a bug in the driver.
> > >What is the
> > >> kernel you are using?
> > >
> > >Ooops! sorry missed that one. Its the 2.6.19-rc5-mm2. Its having the
> > >same .config which i posted on the bugzilla. Do you want the acpidump
> > >again?
> >
> > Not really. There were couple of fixes that went in recently. I can send
> > pointers to those to you.
> >
>
> Ok, I will try them. Can you please point me?
>

I tried the patch at http://lkml.org/lkml/2006/11/15/302 and that
fixes the problem.

Thanks
Dhaval
