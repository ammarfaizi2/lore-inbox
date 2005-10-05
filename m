Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVJEQgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVJEQgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVJEQgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:36:40 -0400
Received: from mail-par.bigfish.com ([217.117.146.230]:64973 "EHLO
	mail11-par-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1030229AbVJEQgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:36:38 -0400
X-BigFish: V
Message-ID: <43440105.9020104@am.sony.com>
Date: Wed, 05 Oct 2005 09:36:21 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net>	<4342DC4D.8090908@perkel.com>	<200510050122.39307.dhazelton@enter.net>	<4343694F.5000709@perkel.com> <17219.39868.493728.141642@gargle.gargle.HOWL>
In-Reply-To: <17219.39868.493728.141642@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> Marc Perkel writes:
> 
> [...]
> 
>  > Right - that's Unix "inside the box" thinking. The idea is to make the 
>  > operating system smarter so that the user doesn't have to deal with 
>  > what's computer friendly - but reather what makes sense to the user. 
>  >  From a user's perspective if you have not rights to access a file then 
>  > why should you be allowed to delete it?
> 
> Because in Unix a name is not an attribute of a file.
> 
> Files are objects that you read, write and truncate. They are
> represented by inodes.
> 
> Separately from that, there is an indexing structure: directory
> tree. Directories map symbolical names to inodes. Obviously, adding a
> reference to an index, or removing it from one requires access
> permission to the _index_ rather then to the object being referenced.
> 
> That two-level model of files and indexing on top of them is essential
> to Unix due to the flexibility and conceptual economy it provides.
>

We should print that on post-it notes for grandmothers
to read when they are interacting with Unix file systems.

>  > 
>  > So - the thread is about the future so I say - time to fix Unix.
> 
> One thing is clear: it's too late to fix Netware. Why should Unix
> emulate its lethal defects?

Like NetWare's defect of it being intuitive and easy to
administer file system rights?  Hey, here's a thought.  Maybe
the operating system could actually exist to SERVE the human
instead of vice versa.
  -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

