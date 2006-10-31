Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423759AbWJaSRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423759AbWJaSRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423761AbWJaSRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:17:20 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57778 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423759AbWJaSRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:17:19 -0500
Subject: Re: [ckrm-tech] RFC: Memory Controller
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Paul Menage <menage@google.com>
Cc: balbir@in.ibm.com, dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
In-Reply-To: <6599ad830610310922p61913cdaqb441a2cb718420a9@mail.gmail.com>
References: <20061030103356.GA16833@in.ibm.com>
	 <4545D51A.1060808@in.ibm.com>
	 <6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>
	 <4545FDCD.3080107@in.ibm.com>
	 <6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>
	 <454782D2.3040208@in.ibm.com>
	 <6599ad830610310922p61913cdaqb441a2cb718420a9@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 10:16:26 -0800
Message-Id: <1162318586.11421.12.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 09:22 -0800, Paul Menage wrote:

> >
> > Hmm... interesting. Why do you think its impossible, what are the kinds of
> > issues you've run into?
> >
> 
> Issues such as:
> 
> - determining from userspace how much of the page cache is really
> "free" memory that can be given out to new jobs without impacting the
> performance of existing jobs
> 
> - determining which job on the system is flooding the page cache with
> dirty buffers
> 

Interesting .. these are exactly questions our database people
have been us asking for few years :)

Thanks,
Badari

