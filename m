Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269800AbUICVub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269800AbUICVub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269808AbUICVub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:50:31 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:15842 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269805AbUICVuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:50:22 -0400
Date: Fri, 3 Sep 2004 23:50:05 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <7410262046.20040903235005@tnonline.net>
To: Chris Dukes <pakrat@www.uk.linux.org>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Helge Hafting <helge.hafting@hist.no>,
       Oliver Hunt <oliverhunt@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>, Adrian Bunk <bunk@fs.tum.de>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <20040903210757.GK32697@ZenIV.linux.org.uk>
References: <helge.hafting@hist.no> <413829DF.8010305@hist.no>
 <200409031741.i83HfASY017164@laptop11.inf.utfsm.cl>
 <518050016.20040903213038@tnonline.net>
 <20040903210757.GK32697@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> On Fri, Sep 03, 2004 at 09:30:38PM +0200, Spam wrote:
>> 
>>   
>> 
>> > Helge Hafting <helge.hafting@hist.no> said:
>> 
>> > [...]
>> 
>> >> The only new thing needed is the ability for something to be both
>> >> file and directory at the same time.
>> 
>> > Then why have files and directories in the first place?
>> 
>>   Good point, we don't need them :) Directories are just a visible
>>   grouping of files to make it easier for the user to manage. But some
>>   things aren't really that intuitive with todays layout - especially
>>   for non-unix users.
>> 
>>   Just an example where the user needs to edit config file for some
>>   program. Where should he look?
>>   /etc/app.conf ?
>>   /etc/app/app.conf ?
>>   /etc/conf.d/app.conf ?
>>   /var/lib/app/app.conf ?
>>   and so on....
>> 
>>   Using file-as-dir isn't really that much of a change. It isn't those
>>   that will confuse people anyway.
>> 

> If the non-computer literate user is expected to edit the config file,
> a pretty interface that hides the internals from the user should be provided.
> For the sake of power users, users that believe themselves to be power users,
> and configuration changes on multiple systems.
> 1) Track the location of the config file with the native package management
> system.
> 2) Keep a human readable/editable format.
> 3) Provide APIs or schema so that the files may be parsed for correctness,
> or edited or created programatically.
> 4) Provide a tool that not only checks for a parseable file, but does
> sanity checks such as (Does file exist).

> I'm at a loss as to how any of this has anything to do with filesystems.
> The closest I see is one implementation of the above (gconf2) happens to
> use the filesystem for it's default hierarchical database backend.

  The relevance was as to the presentation of meta-data, streams and
  such and their implication on users.

  I just used the example of config files because there are not so
  much of a standard among them. Administrators still need to learn
  and remember where and what to backup. This wouldn't be so much of a
  change if they decide to introduce some usage for meta-data or named
  streams.

  Remember, even if the functionality exist you do not have to use
  everything of it.
  
> As for developers that are too stupid/lazy to provide the GUI and meet
> the other criteria...  I suggest extensive use of cattle prods on
> them as they attend an automata class.

  Lets all start with the bash(ing) ;).

  But really. What you say is true. The users do not care so much
  about what is going on below the curtains. Here is where the clash
  between different groups of Linux users and developers appear most
  vivid.

  Sure KDE and Gnome are on their way, but their efforts still have a
  long way to go. They still don't talk to eachother to strive for a
  comon goal - but competes instead (which may even be a good thing).

  ~S


