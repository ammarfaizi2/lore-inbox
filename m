Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132352AbRC1UAw>; Wed, 28 Mar 2001 15:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132143AbRC1UAm>; Wed, 28 Mar 2001 15:00:42 -0500
Received: from james.kalifornia.com ([208.179.59.2]:36218 "EHLO james.kalifornia.com") by vger.kernel.org with ESMTP id <S132147AbRC1UAZ>; Wed, 28 Mar 2001 15:00:25 -0500
Message-ID: <3AC1D1B8.9080507@kalifornia.com>
Date: Wed, 28 Mar 2001 03:57:44 -0800
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i586; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Williams <announce@sis-domain.demon.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
References: <01032806093901.11349@tabby> <Pine.GSO.3.96.1010328144551.7198A-100000@laertes> <F6Om1QA+9ew6EwTq@sis-domain.demon.co.uk> <20010328100440.A5941@zalem.puupuu.org> <ZEABaXAGggw6EwTH@sis-domain.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Williams wrote:

> In message <20010328100440.A5941@zalem.puupuu.org>, Olivier Galibert
> <galibert@pobox.com> writes
> 
>> On Wed, Mar 28, 2001 at 03:04:46PM +0100, Simon Williams wrote:
>> 
>>> I think their point was that a program could only change permissions
>>> of a file that was owned by the same owner.  If a file is owned by a
>>> different user & has no write permissions for any user, the program
>>> can't modify the file or it's permissions.
>> 
>> You mean, you usually have write permissions for other than the owner
>> on executable files?
>> 
>> Let me reformulate that.  You usually have write permissions for other
>> than the owner, and not only on some special, untrusted log files (I'm
>> talking files, here, not device nodes)?  What's your umask, 0?
>> 
> 
> Firstly, I'm relatively new to Linux (only about 3 yrs experience) &
> don't claim to be an expert.  Secondly, I don't think I stated my point
> very clearly.
> 
> No, I don't have write permissions set on an executable for any user
> other than the owner.
> 
> What I meant was that if a file is owned by root with permissions of,
> say, 555 (r-xr-xr-x), not setuid or setgid, then another executable
> run as a non-root user cannot modify it or change the permissions to
> 7 (rwx).

There are two problems I see here.  First, there are several known ways 
to elevate privileges.  If a virus can elevate privileges, then it owns 
you.  Second, this is a multi-OS virus.  If you dual-boot into Windows,  
any ELF files accessible can be infected.  With this one, that isn't a 
prob, but when somebody codes in an ext2 driver to their virus, then 
we've got issues.

-b

