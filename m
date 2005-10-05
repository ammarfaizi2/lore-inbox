Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVJENVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVJENVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 09:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbVJENVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 09:21:47 -0400
Received: from 10.ctyme.com ([69.50.231.10]:12006 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S965166AbVJENVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 09:21:46 -0400
Message-ID: <4343D367.5030608@perkel.com>
Date: Wed, 05 Oct 2005 06:21:43 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net>	<4342DC4D.8090908@perkel.com>	<200510050122.39307.dhazelton@enter.net>	<4343694F.5000709@perkel.com> <17219.39868.493728.141642@gargle.gargle.HOWL>
In-Reply-To: <17219.39868.493728.141642@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nikita Danilov wrote:

>Marc Perkel writes:
>
>[...]
>
> > Right - that's Unix "inside the box" thinking. The idea is to make the 
> > operating system smarter so that the user doesn't have to deal with 
> > what's computer friendly - but reather what makes sense to the user. 
> >  From a user's perspective if you have not rights to access a file then 
> > why should you be allowed to delete it?
>
>Because in Unix a name is not an attribute of a file.
>
>Files are objects that you read, write and truncate. They are
>represented by inodes.
>
>Separately from that, there is an indexing structure: directory
>tree. Directories map symbolical names to inodes. Obviously, adding a
>reference to an index, or removing it from one requires access
>permission to the _index_ rather then to the object being referenced.
>
>That two-level model of files and indexing on top of them is essential
>to Unix due to the flexibility and conceptual economy it provides.
>  
>
Now of you think "outside" the Linux box" you can see where people in 
the real world would expect that if you have no rights to a file to read 
or write to it that you shouldn't be able to delete it. In the outside 
world it's "duh - of course"! but for thouse that are in the "Unix Cult" 
you can't think past inodes.

> > 
> > Now - the idea is to create choice. If you need to emulate Unix nehavior 
> > for compatibility that's fine. But I would migrate away from that into a 
> > permissions paradygme that worked like Netware.
>
>And there are people believing that ITS (or VMS, or <insert your first
>passion here>...) set the standard to follow. :-)
>
>[...]
>
> > 
> > So - the thread is about the future so I say - time to fix Unix.
>
>One thing is clear: it's too late to fix Netware. Why should Unix
>emulate its lethal defects?
>
>Nikita.
>  
>

Once you'be had Netware permissions - even 1990 Netware permission - you 
are spoiled and everything else isn't even close.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

