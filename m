Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287908AbSBIWAP>; Sat, 9 Feb 2002 17:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287895AbSBIWAG>; Sat, 9 Feb 2002 17:00:06 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:39627 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S287840AbSBIWAC>;
	Sat, 9 Feb 2002 17:00:02 -0500
Date: Sat, 09 Feb 2002 21:59:56 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mike Touloumtzis <miket@bluemug.com>,
        Daniel Phillips <phillips@bonn-fries.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <2350931647.1013291995@[195.224.237.69]>
In-Reply-To: <20020207210823.GH26826@bluemug.com>
In-Reply-To: <20020207210823.GH26826@bluemug.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, 07 February, 2002 1:08 PM -0800 Mike Touloumtzis 
<miket@bluemug.com> wrote:

> My understanding is that "keep features out of the kernel if possible"
> is the majority opinion, not a crackpot weirdo stance.

Mmmm... well my understanding is that the majority opinion is not
to minimize kernel functionality as a goal in isolation, but to
minimize putting into the kernel features which are done just
as well in userspace. Note the words 'just as well'. Consider,
for instance, the recent discussion (like it or not) on packing
some initrd equivalent with modules for all drivers, as opposed
to keeping said modules in separate files on traditional disk
storage. I cite this as it's about the closest analogy.

The argument comes down to 'do you want the option of dealing
with your kernel as one lump, or multiple smaller lumps' (i.e.
kernel as we know it, modules, ksysms, config file, tea cosy,
jacuzzi etc. - remember I suggested one be able to stick
any files there). It seems sensible at a distribution level to
restrict the use of this option (you could put the whole of
/bin there if you wanted). It seems perverse to reject the
concept of the option in toto, given that it's, urm, an option.
Just like any option, it is possible, though far from compulsorary,
to mindlessly abuse it.

--
Alex Bligh
