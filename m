Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289004AbSAIU3e>; Wed, 9 Jan 2002 15:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289005AbSAIU3Z>; Wed, 9 Jan 2002 15:29:25 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:56728 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S289004AbSAIU3V>;
	Wed, 9 Jan 2002 15:29:21 -0500
Date: Wed, 09 Jan 2002 20:29:16 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@turbolabs.com>
Cc: Kervin Pierre <kpierre@fit.edu>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: fs corruption recovery?
Message-ID: <1379421486.1010608155@[195.224.237.69]>
In-Reply-To: <200201090326.g093QBF27608@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200201090326.g093QBF27608@vindaloo.ras.ucalgary.ca>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, 08 January, 2002 8:26 PM -0700 Richard Gooch 
<rgooch@ras.ucalgary.ca> wrote:

> I contacted one of these
> recovery companies. I wanted to know if they could recover the bad
> sectors. I was told no. After some probing, it turns out that all they
> do is basically what I was doing. They just charge $2000 for it.

You are talking to the wrong data recovery company. There
are companies in the UK I know of (and I'm sure elsewhere)
who go further, for instance
a) Physical cleaning of drive and electronics (useful if
   a water release fire suppression, or foam fire suppression
   has just washed crap all over it).
b) Swapping controller electronics with known working
   drive (to combat fried electronics or physical damage
   to PCB).
c) Go to clean room, remove platters, clean carefully,
   insert into known working drive
d) Read sectors multiple times varying various parameters
   to build up statistical bitmaps of sectors which fatally
   fail CRC checks.

Now I'm not a DR person but I know 2 people who have worked
for them. I'm sure you can do much of this yourself if you
dare^Wtry, but I think many /do/ do more than keep reading
the same sector multiple times (FWIW if you want this to
work I recommend resetting the drive, and/or powering it
down after every n attempts at a read, then doing a seek
to a random position - this used to help).

--
Alex Bligh
