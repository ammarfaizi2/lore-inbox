Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbSJLJ6D>; Sat, 12 Oct 2002 05:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262869AbSJLJ6C>; Sat, 12 Oct 2002 05:58:02 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:45578 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262868AbSJLJ6C>; Sat, 12 Oct 2002 05:58:02 -0400
Message-ID: <3DA7F385.3040409@namesys.com>
Date: Sat, 12 Oct 2002 14:03:49 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 - (NUMA))
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net> <3DA7647C.3060603@namesys.com> <20021012012807.1BB5B635@merlin.webofficenow.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

>I'm also looking for an "unmount --force" option that works on something 
>other than NFS.  Close all active filehandles (the programs using it can just 
>deal with EBADF or whatever), flush the buffers to disk, and unmount.  None 
>of this "oh I can't do that, you have a zombie process with an open file...", 
>I want  "guillotine this filesystem pronto, capice?" behavior.
>
This sounds useful.  It would be nice if umount prompted you rather than 
refusing.

>
>Of course loopback mounts would be kind of upset about this, but to be 
>honest: tough.  The loopback block device gives them an I/O error, and the 
>filesystem should just cope.  Floppies do this all the time with dust and cat 
>hair and stuff...
>
>Of course I don't yet know 1/10 as much about the VFS as I need to, but I'm 
>learning.  Slowly...
>
>Rob
>
>
>  
>



