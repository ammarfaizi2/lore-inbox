Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131454AbRC1Nx4>; Wed, 28 Mar 2001 08:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131660AbRC1Nxq>; Wed, 28 Mar 2001 08:53:46 -0500
Received: from james.kalifornia.com ([208.179.59.2]:34420 "EHLO james.kalifornia.com") by vger.kernel.org with ESMTP id <S131454AbRC1Nxf>; Wed, 28 Mar 2001 08:53:35 -0500
Message-ID: <3AC17BB1.8000201@kalifornia.com>
Date: Tue, 27 Mar 2001 21:50:41 -0800
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i586; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: jesse@cats-chateau.net
CC: Shawn Starr <spstarr@sh0n.net>, Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
References: <Pine.LNX.4.30.0103280225460.8046-100000@coredump.sh0n.net> <01032806093901.11349@tabby>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:

> On Wed, 28 Mar 2001, Shawn Starr wrote:
> 
>> Well, why can't the ELF loader module/kernel detect or have some sort of
>> restriction on modifying other/ELF binaries including itself from changing
>> the Entry point?
>> 
>> There has to be a way stop this. WHY would anyone want to modify the entry
>> point anyway? (there may be some reasons but I really dont know what).
>> Even if it's user level, this cant affect files with root permissions
>> (unless root is running them or suid).
>> 
>> Any idea?
> 
> 
> Sure - very simple. If the execute bit is set on a file, don't allow
> ANY write to the file. This does modify the permission bits slightly
> but I don't think it is an unreasonable thing to have.
> 
What a pain in the ass when you are writing / updating a shell script . 
. . .

