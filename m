Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289043AbSAIWNb>; Wed, 9 Jan 2002 17:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289048AbSAIWNN>; Wed, 9 Jan 2002 17:13:13 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:12185 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S289043AbSAIWMu>;
	Wed, 9 Jan 2002 17:12:50 -0500
Date: Wed, 09 Jan 2002 22:12:45 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Anton Altaparmakov <aia21@cam.ac.uk>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Greg KH <greg@kroah.com>, felix-dietlibc@fefe.de,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <1385616310.1010614365@[195.224.237.69]>
In-Reply-To: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, 09 January, 2002 9:34 PM +0000 Anton Altaparmakov 
<aia21@cam.ac.uk> wrote:

>> seriously point: ls /sbin gives a /maximum/ range I'd
>> have thought.
>
> Partition discovery is currently done within the kernel itself. The code
> will effectively 'just' move out into user space.

Apologies - of course; I meant ls /sbin union {anything moved
out of kernel} gives a maximum range. I could find rationales,
some more questionable than others, for about half the stuff
in /sbin (for instance, if you are mounting NFS over IP, you
/might/ want to have iptables support in there before you start
playing with ip operations which without them might cause
a comprimized root to be mounted - I said /might/).

--
Alex Bligh
