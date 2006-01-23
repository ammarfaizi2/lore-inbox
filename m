Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWAWRvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWAWRvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWAWRvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:51:12 -0500
Received: from smtpout.mac.com ([17.250.248.44]:46037 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964850AbWAWRvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:51:12 -0500
In-Reply-To: <84144f020601230900x477dd21am8d94f382e37c5072@mail.gmail.com>
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org> <43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org> <4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com> <20060123072447.GA8785@thunk.org> <536E71BF-44FF-430C-8C19-F06526F0C78D@mac.com> <69304d110601230552n4c7656cal9c6901e180e82504@mail.gmail.com> <CEED5F58-EF3D-44D9-9C54-FE1720640E11@mac.com> <84144f020601230900x477dd21am8d94f382e37c5072@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A31CA9FF-4B56-483C-8BCC-CECD9B812844@mac.com>
Cc: Antonio Vargas <windenntw@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Linux VFS architecture questions
Date: Mon, 23 Jan 2006 12:50:56 -0500
To: Pekka Enberg <penberg@cs.helsinki.fi>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 23, 2006, at 12:00, Pekka Enberg wrote:
> Hi Kyle,
>
> On 1/23/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> Great!  I'm trying to learn about filesystem design and  
>> implementation, which is why I started writing my own hfsplus  
>> filesystem (otherwise I would have just used the in-kernel one).   
>> Do you have any recommended reading (either online or otherwise)  
>> for someone trying to understand the kernel's VFS and blockdev  
>> interfaces?  I _think_ I understand the basics of buffer_head,  
>> super_block, and have some idea of how to use aops, but it's tough  
>> going trying to find out what functions to call to manage cached  
>> disk blocks, or under what conditions the various VFS  functions  
>> are called.  I'm trying to write up a "Linux Disk-Based Filesystem  
>> Developers Guide" based on what I learn, but it's remarkably  
>> sparse so far.
>
> Did you read Documentation/filesystems/vfs.txt?

Yeah, that was the first thing I looked at.  Once I've got things  
figured out, I'll probably submit a fairly hefty patch to that file  
to add additional documentation.

> Also, books Linux Kernel Development and Understanding the Linux  
> Kernel have fairly good information on VFS (and related) stuff.

Ah, thanks again!  It looks like both of those are available through  
my university's Safari/ProQuest subscription (http:// 
safari.oreilly.com/), so I'll take a look right away!

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


