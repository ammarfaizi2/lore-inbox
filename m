Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279003AbRKDVXS>; Sun, 4 Nov 2001 16:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279024AbRKDVXI>; Sun, 4 Nov 2001 16:23:08 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:676 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S279003AbRKDVWv>;
	Sun, 4 Nov 2001 16:22:51 -0500
Date: Sun, 04 Nov 2001 21:22:47 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        =?ISO-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <627833590.1004908966@[195.224.237.69]>
In-Reply-To: <200111042112.fA4LCNR241720@saturn.cs.uml.edu>
In-Reply-To: <200111042112.fA4LCNR241720@saturn.cs.uml.edu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, 04 November, 2001 4:12 PM -0500 "Albert D. Cahalan" 
<acahalan@cs.uml.edu> wrote:

>> Now you are proposing to dink with the format. See above comments.

Attribution error: that was me, disagreeing with Jakob - the point was
if you want to dink with the format to achieve the objectives
he seemed to be after (which I thought were to do at least
in part with consistency etc.), it is theoretically possible
to do such dinking with minimal change & certainly retain
text format (and note I said retain original /proc files too). Whether
it's worth it as a practical exercize, with all the inherent
disruption it would no doubt cause, and questionable net benefit
is a completely different question. I was just saying that
binary format wasn't necessary to achieve what I think
Jakob wanted to achieve. The full thought
experiment was in a later email. I suspect you don't disagree
given your previous post.

>>> 3. Try and rearrange all the /proc entries this way, which
>>>    means sysctl can be implemented by a straight ASCII
>>>    write - nice and easy to parse files.
>
> This is exactly what the sysctl command does.

Sorry, I meant 'this way a consistent interface cf
sysctl could be used for more of what's currently
done through /proc'. Last time I looked there was
stuff you could read/write to through /proc which
couldn't be done through sysctl.

--
Alex Bligh
