Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVLFVtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVLFVtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVLFVtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:49:52 -0500
Received: from mail.dvmed.net ([216.237.124.58]:35737 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030259AbVLFVtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:49:51 -0500
Message-ID: <43960774.1000202@pobox.com>
Date: Tue, 06 Dec 2005 16:49:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Brian Gerst <bgerst@didntduck.org>, Arjan van de Ven <arjan@infradead.org>,
       "M." <vo.sinh@gmail.com>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Reverse engineering (was Re: Linux in a binary world... a doomsday
 scenario)
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	 <20051205121851.GC2838@holomorphy.com>	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>	 <20051206030828.GA823@opteron.random>	 <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>	 <1133869465.4836.11.camel@laptopd505.fenrus.org>	 <4394ECA7.80808@didntduck.org>  <4395E2F4.7000308@pobox.com>	 <1133897867.29084.14.camel@mindpipe>  <4395E962.2060309@pobox.com> <1133898911.29084.25.camel@mindpipe>
In-Reply-To: <1133898911.29084.25.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Lee Revell wrote: > On Tue, 2005-12-06 at 14:41 -0500,
	Jeff Garzik wrote: > >>Lee Revell wrote: >> >>>On Tue, 2005-12-06 at
	14:13 -0500, Jeff Garzik wrote: >>> >>>>Let's hope the rev-eng people
	do it the right way, by having one team >>>>write a document, and a
	totally separate team write the driver from >>>>that document. >>
	>>>Isn't it also legal for a single person or team to capture all IO
	>>>to/from the device with a bus analyzer or kernel debugger and write
	a >>>driver from that, as long as you don't disassemble the original
	driver? >> >>It's still legally shaky. The "Chinese wall" approach I
	described above >>is beyond reproach, and that's where Linux needs to
	be. > > > I know you are not a lawyer but do you have a pointer or two?
	As long > as we are REing for interoperability I've never read anything
	to > indicate the approach I described could be a problem even in the
	US. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-12-06 at 14:41 -0500, Jeff Garzik wrote:
> 
>>Lee Revell wrote:
>>
>>>On Tue, 2005-12-06 at 14:13 -0500, Jeff Garzik wrote:
>>>
>>>>Let's hope the rev-eng people do it the right way, by having one team 
>>>>write a document, and a totally separate team write the driver from
>>>>that document.
>>
>>>Isn't it also legal for a single person or team to capture all IO
>>>to/from the device with a bus analyzer or kernel debugger and write a
>>>driver from that, as long as you don't disassemble the original driver?
>>
>>It's still legally shaky.  The "Chinese wall" approach I described above 
>>is beyond reproach, and that's where Linux needs to be.
> 
> 
> I know you are not a lawyer but do you have a pointer or two?  As long
> as we are REing for interoperability I've never read anything to
> indicate the approach I described could be a problem even in the US.

The _potential_ for problems is very high:

1) [ref Alan's email] copying programming sequences

2) Lack of Chinese wall requires TRUST and EVIDENCE that you did the 
rev-eng without "source code that fell off the back of a truck" [i.e. 
illegally obtained] or "docs that fell off the back of a truck."

3) Lack of Chinese wall increases the likelihood that a SCOX or other 
entity could use that as a legal weapon against Linux.

In Linux, I really have no way of knowing how questionable a driver 
submission is, if it did not arrive from the Chinese wall approach, or a 
known hacker with a valid path to hardware docs/engineers/code.  Past 
experience shows that Mr. Unknown Hacker is likely to take legal 
shortcuts when writing the driver.

If I accept code of highly questionable origin, then I put Linux in 
jeopardy.

	Jeff


