Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268209AbUH2Q5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268209AbUH2Q5S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUH2Q4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:56:42 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:57480 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268200AbUH2Qxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:53:31 -0400
Date: Sun, 29 Aug 2004 18:54:50 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1691055525.20040829185450@tnonline.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Hans Reiser <reiser@namesys.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       Rik van Riel <riel@redhat.com>, Spam <spam@tnonline.net>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, <christophe@saout.de>,
       <vda@port.imtp.ilyichevsk.odessa.ua>, <christer@weinigel.se>,
       Andrew Morton <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>,
       <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <200408291521.i7TFLsQk028363@localhost.localdomain>
References: Your message of "Fri, 27 Aug 2004 22:44:04 +0200."
 <1732169380.20040827224404@tnonline.net>
 <200408291521.i7TFLsQk028363@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Spam <spam@tnonline.net> said:
>> Horst von Brand <vonbrand@inf.utfsm.cl> said:
>> > Hans Reiser <reiser@namesys.com> said:
>> >> Andrew Morton wrote:

> [...]

>> >> Andrew, we need to compete with WinFS and Dominic Giampaolo's filesystem
>> >> for Apple,
>> 
>> > Says who?
>> 
>>   At  least  I  as  a user see the benefits largely. The workstation /
>>   desktop  user has much more need for such features, than perhaps the
>>   normal Linux sysadmin.

> Show benefits, show there are no downsides. Show that the same can't
> possibly be done in userland. Then I'll consider buying it.

  I am not saying it couldn't be done in userland. Most things can.

  The  problem with userland is that it doesn't provide generic access
  across  most  applications. For example GnomeVFS is limited to Gnome
  applications  only.  The  same  for  KDE.  to  be able to coordinate
  application developer on anything is just almost impossible.

  Still.  Why do you oppose plugins, streams and meta files? The could
  be   valuable   and  easy  to use tools for many purposes. One could
  be  would be advanced ACLs defined as a meta-file using XML format.
  

> AFAICS: Smallish benefits for some narrow application niche. Mayor problems
> (no decent multiuser way of using it, extremely complex stuff placed in the
> kernel). Userland solutions are all around us right now, and work just
> fine. No, placing the same gunk in the kernel won't make it magically use
> no time or memory, more like exactly the opposite. Besides, all the visions
> waved around here have very little in common (except the idea that they
> make all restrictions magically dissapear).

> Get a list of required features, show concrete ways of using it, outline
> possible implementations, discuss resource usage. I.e., do "engineering".
> Then we have something to discuss.

  I  am not sure what you refer to as "required features". Do you mean
  example of usage and contents for streams, plugins and meta files?

>> >>            and that means we need to put search engine and database
>> >> functionality into the filesystem.

>> > Please don't. Unix works and is extremely popular because it _doesn't_ try
>> > to be smart (policy vs mechanism distinction, simple abstractions that can
>> > be combined endlessly). If you add this to the filesystems, you either redo
>> > _all_ userland to understand _one_ particular way of doing "smart things"
>> > (which will turn out to be almost exactly the dumbest possible for some
>> > uses, and then you are stuck), or get lots of shards from broken apps (and
>> > users, and sysadmins).

>>   Indeed.  But  you forget one thing. Combining lots of small userland
>>   tools can actually make things more complex - at least for the user.

> So? Placing lots of little things in kernel does the same, plus screws over
> sysadmins, and makes kernel hacker's job harder. I prefer the former alone.

  Difference being that it could be transparent in a way otherwise not
  possible.

>>   That said, I do not see that anyone has suggested to remove this way
>>   of  working with applications.

> Excuse me, if files suddenly become directories, and you can't have some
> "reserved" file/directory names, and... you are breaking lots of stuff.

>>   Are the new and old features mutually exclusive?

> Yep.

>> >>                                     It takes 11 years of serious
>> >> research to build a clean storage layer able to handle doing that.
>> 
>> > Great! Build an experimental OS showing how to use it, and through that see
>> > if the ideas hold any water _in real, day-to-day, down-to-earth, practice_.

>>   There  are  many  uses already.

> Where?

>>                                   It could be encryption, compression,
>>   meta-data,  file streams, sorting, searching and a multitude of uses
>>   and ideas that haven't been discovered yet.

> "Could", "multitude ... haven't been discovered yet" is _not_ "many current
> uses".

>> >> Reiser4 has done that, finally.  None of the other Linux filesystems
>> >> have.

>> > How come nobody before you in the almost 30 years of Unix has ever seen the
>> > need for this indispensable feature?

>>   I,  as  a  user, have for a long time. Do not drag everyone over the
>>   same  edge.  Users  have  different  needs.  We  should try to be as
>>   forthcoming as possible to provide the tools and options for them.

> Why? Breaking the basic paradigms for some user whim is not good OS design
> in my book, sorry. Many "bright ideas" have been thrown out over the years
> for just the same reasons.

>> >>        The next major release of ReiserFS is going to be bursting with
>> >> semantic enhancements, because the prerequisites for them are in place
>> >> now.  None of the other Linux filesystems have those prerequisites.

>> > To me that would mean that ReiserFS has no place in Linux.

>>   Why  do  you say this? I thought Linux embraced advancements and new
>>   technologies.

> If they are right. I think breaking the base of the OS is not a good
> idea. Perhaps ReiserFS has a place elsewhere (in MacOS, or Windows, where
> this is supposedly so so badly needed?), but not here.

  You  mean  in  Windows  and  MacOS  where much of this functionality
  already exists?

>> >> They won't be able to keep up with the semantic enhancements.  This
>> >> metafiles and file-directories stuff is actually fairly trivial stuff.

>> > Maybe. But the question of it being of any use aren't trivially answered
>> > "yes". My gut feeling is that the answer is a resounding "no", but that's
>> > just me. Direcories are directories, if you want to ship directory-like
>> > stuff around, use directories (or tarfiles, or whatever). Just look what
>> > happened to the much, much easier stuff of splitting SUID/SGID into
>> > capabilities: Nothing at all whatsoever, because they have no decent place
>> > to stay in the hallowed Unix APIs. Sure, Linux is now large enough to be
>> > able to _define_ APIs to follow, but even so it isn't at all easy to do so.

>>   Exactly.  The  problem  I see in this discussion is the lack of just
>>   this - APIs. Because the lack of good APIs we cannot make any larger
>>   changes or bring new features because old applications will break.


  I'll chop this up...
  
> No. There is a complete lack of answers to why it should be done ("I think
> it would be nice", "MSFT is trying to do it", "Look at MacOS" is far from
> enough)

  No   perhaps  not  by itself. But it certainly should be considered.
  These  two  OS'es  have  most  of  the market share. They have great
  resources  trying to make things that work for their users.

  Users  are  more  important  than you think. Linux and any OS can do
  what  it  wants, but if it wants to keep users then it has to listen
  to them.

> , on what the alternatives are ("Sorry, it must be in the kernel
> because it is impossible to get application writers to agree on how to do
> it"

  This  is  a  perfectly  valid  reason.  If  it  is necessary to move
  something  into  the  core of Linux because it couldn't otherwise be
  done then it should seriously be considered.

>  will just add another incompatible way of "doing almost the same", this
> time in the kernel),

   People  on  this  list  are  actually trying to make it to be fully
   compatible with old legacy applications.

   If  you  hadn't noticed, Reiser4 does work. The meta files do work.
   The  discussion  is  wether parts of Reiser4 should be made generic
   and fit into the VFS.

>  and last but not least what the impact is (performance
> wise, application breakage, user/sysadmin expectation breakage,
> incompatibility with other systems, kernel development impact, to list a
> few). Hash this out, and we can talk.

  You  paint up a doomsday picture here. Nothing of this magnitude has
  happened  and  won't. besides, what is wrong if sysadmins would have
  to learn something new?

>>   I think that Linux should make new API that will completely separate
>>   applications  from the storage media. This way we will not as easily
>>   break  applications  when new features are developed. This should be
>>   the main priority.

> The "files + directories" stuff is a nice abstraction, and works today on
> all random-access storage media. You don't care much if it is on a CD, a
> floppy, a disk, a RAID array, or a flash card, do you? It won't work on
> tapes, or printers; but that is to be expected.

  you  didn't  actually  comment  on  what  I  said. I mentioned API's
  nothing about directories and files. API being the keyword here.

  If  there  are  good API's that applications can use, for example to
  access filesystems, then it will be easier and much more possible to
  introduce  new  things into the filesystem without breaking existing
  applications.  One  example of preventing application breakage could
  be   to   have  a  versioning system. Applications could query which
  version is supported, or vice versa.

  From  what  I  understand  it  is  much  harder to do anything today
  because of the fixed ways. This is why we have this discussion.

> [...]

>>   Application  breakage  has  happened  before between virtually every
>>   kernel change. It isn't new. Just take devfs and sysfs.

> Oops, now emacs stopped working because devfs was added? gcc needed a mayor
> overhaul because of /sys vs /proc? Gimme a break. That was _basic system tool_
> breakage, not all-around application breakage.

  Emacs  seem  to  work  fine  with  the  file-as-dir  on  my  Reiser4
  partition. And so does actually any other application I have used on
  it. Be it in Gnome, KDE or in plain shell's.

>> >> Look guys, in 1993 I anticipated the battle would be here, and I build
>> >> the foundation for a defensive tower right at the spot MS and Apple are
>> >> now maneuvering towards.
>> 
>> > Why place a protective tower around the pit into which they are trying
>> > desperately to throw themselves? ;-)
>> 
>>   It  is easy to say this. But the fact is that users can actually use
>>   these new features for good things.

> And can abuse them for bad things, and the features aren't free. Balance
> benefits (very minor) against costs (quite large).

  Abuse depends on permissions and security policies which is your job
  as admin to look after.

  It  would  be  possible to limit, for example), the types of plugins
  that a user can either use or load.

  Do you give your users access to modprobe or tools like that?

>> >>                           Help me get the next level on the tower before
>> >> they get here.  It is one hell of a foundation, they won't be able to
>> >> shake it, their trees are not as powerful.  Don't move reiser4 into vfs,
>> >> use reiser4 as the vfs.  Don't write filesystems, write file plugins and
>> >> disk format plugins and all the other kinds of plugins, and you won't be
>> >> missing any expressive power that you really want....
>> 
>> > Better write libraries handling whatever weird format you have in mind for
>> > each use. Even applications. I don't expect to be able to use emacs to edit
>> > a JPEG or PostgreSQL database. Neither do I expect gimp to be able to edit
>> > a poem. The current trend (which I heartily agree with) is to take stuff
>> > _out_ of the kernel (for flexibility, access, development ease, even
>> > performance).

>>   If  I  want  to  be able to quickly find files by a certain author I
>>   could   search  the  meta-data fields (if they are used) with normal
>>   tools such as grep.

> Iff the metadata is there. It won't (everybody would have to agree on
> placing that on the files for it to work), so it is useless.

  No  it  is  not  useless.  It  just  means  the  file  has  no  meta
  information. Just as it is today. No change.

>>   Compression or encryption is another example.
>> 
>>   Would  you  rather  patch  every  application  there is for Linux to
>>   enable support for reading these files and directories?

> No. But an encrypted or compressed filessytem doesn't need weird files.
> Easiest on applications is just to serve the decrypted/uncompressed files
> for use via the traditional APIs. Next easiest is provide programs that
> handle cryptography and compression and can be combined with whatever
> unaware program you care to use. Funny, that is exactly the way things work
> now...

  So you can setup a directory that has some files compressed and some
  other  encrypted and yet they will be available to use with tar, cp,
  ls, mc, Nautilus, Emacs etc etc?

