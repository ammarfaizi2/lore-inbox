Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129621AbQIHDwP>; Thu, 7 Sep 2000 23:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129469AbQIHDvz>; Thu, 7 Sep 2000 23:51:55 -0400
Received: from ix.netcorps.com ([207.1.125.106]:15330 "EHLO ix.netcorps.com") by vger.kernel.org with ESMTP id <S129457AbQIHDvw>; Thu, 7 Sep 2000 23:51:52 -0400
From: Jeff Merkey <jmerkey@timpanogas.com>
Reply-To: jmerkey@timpanogas.com
Organization: TRG
To: linux-kernel@vger.kernel.org
Subject: Linux Kernel Debugger
Date: Thu, 7 Sep 2000 19:13:48 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Message-Id: <00090720503600.00562@nwfs.timpanogas.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

I gave the whole Social Darwinsim argument you raised with the parable of
the rabbits and the wolves relative to a kernel debugger in Linux considerable
thought, and I guess that darwinism never did handle events well like 6 mile
diameter meteors striking the earth at 165,000 miles per hour in the cretaceous
period and wiping out the dinosaurs, or giant volcanic caldera's forming on the
earths surface and creating acid rain that killed off 96% of all species on
earth in the late Permian period.  

I think if our destiny were up to darwinism, we would be doing what the rest of
the life forms on earth do, and leave our computers to go rut around for 
something to eat all the time in between sleeping and mating.  Natural Selection
does not seem to favor intelligence, as evidenced by the high mortality rate of
our brightest people and children (really bright children tend to do things like
pull pots of boiling water down on themselves and walk out in front of cars,
play with matches, stick their hands in a tiger's cage at the zoo, etc.).   Our
large brain capacity developed by accident as a result of early humans being
scavengers that followed pliocene cats species that preyed on the mega-fauna
that existed when proto-humans first appeared -- a result of a diet based
almost totally on protein.  A random event to be sure that involves complex
dynamics not attributable to natural selection and darwinsim alone.     

I think your approach to kernel development will certainly create some very
capable programmers with proficient skills at reading through and
maintaing source code.   There is a class of problems, however, that no amount
of study or review can anticipate, such as flaky hardware, and classes of SMP
problems where several processors corrupt something in memory.  I can write an
SMP operating system without any tools or a debugger.  That's how I wrote MANOS
-- Wolf Mountain -- and the debugger I am putting into Linux -- with code
reviews only -- it just came up and worked.  But in order for me to obtain these
skills, it took years of study and learning about hardware and SMP interactions
with inverse assemblers and a host of tools and debuggers to monitor timed
events with live systems to understanding how everything fits together.  

Debugging distributed databases like NDS across 100 machines can get pretty
tough without sophisticated tools to catch events and bugs.  It's true that
someone can just write a code stub or message for some of these these cases, but
it's faster, funner, and easier with capable, integrated tools.  

I have only been working on Linux for about 18 months in earnest, and have a
very good understanding of several subsystems, and as I tear it apart more, I
am understanding more of it, but with a debugger I could have quickly
instrumented it and learned much more quickly   I guess what it comes down to is
personal style in the end and how you want to run your group, Linus.  This
does make you God and means that Linux will only progress as fast of you
do, since you review most of the changes and make the final call on a
majority ofthe decision.   This is probably OK, though, since the "benevolent
dictator" model is shown to work.   This is what went on at Novell.  Drew Major
was the "Linus" of Novell, and surprisingly,  a lot of the things you say are
similiar to what he used to say about people not being careful, etc.  He loved
NetWare, and it was his "baby".   He had a following of core folks a lot like
you do.    What happened here though was that NetWare was only allowed to
advance as fast as he did, since he had to understand everything folks were
doing before allowing changes to be made to the tree of NetWare.   It worked
at Novell for about 14 years, but in the end, as the world changed, Drew did
not, and NetWare became a millstone around his neck.   Changes that he once
could do effortlessly got harder for him for whatever reason, and he took
longer and longer to get releases out -- kind of like the pattern of Linux 2.4.

Fortunately, humanity's fate isn't tied to darwinsin.  If a large asteroid
approaches earth today, there are dozens of listening posts will herald it's
arrival and no doubt we would fire nukes at it or something (there are
approximately 8 "killer" asteroids that cross earth's path that we monitor
today from these stations -- God only knows what we would do if one looked like
it was on course for a collision with the earth).   If a giant piece or rock
100 miles across slammed into the earth today at 165,000 miles per hour, so
much for Linux, Darwinisn, Life period -- over and out -- I guess Darwinsm
didn't equip the dinosarus and cynodonts very well.     

Linux isn't a living thing like you and I and is not defined by strands of
DNA.  We are only the phenotypical expression of our genetic legacy.  Linux and
other creative works of man are not bound by fixed rules, but by the
imaginations of those who nurture them.

Programming is a lot like art, music, and those things man creates with his
intellect that transcend darwinsm.    I don't think it matters, Linus, whether
a person likes to use a kernel debugger or not, or that there is any
correllation to the skills or contributions of any programmer who works on
Linux if they do it with a kernel debugger or without.  I don't think having a
preference or using one or not will provide any individual any advantage one
way or the other.

I think what it boils down to is that Linux is your child, you love it with all
the passion a parent has for a child, and you want evryone else to love it just
as much, and to take the same meticulous care that you yourself practice in
carrying it forward.    

For whatever it's worth, you told me to go off and think about it, then let
you know what I thought and I have.  kdb, MANOS, xyz debugger I do not think
makes any difference one way or the other to the end result, except that some
folks may have more time to spend with their children and spend less time
reading through code and drinking coffee and tea, and staying up til 1:00
a.m. every night, which seems to be the new pattern at my house every evening
when I crank up my Linux machine and work late at home every night learning and
studying pulling apart the Linux tree.  

I will finish porting the MANOS debugger, and offer it.  You should go off and
think about what I said.  

Also, I have an update regarding [you know who] and my approach to
Microsoft we relayed last week.  As a result of going to Microsoft and asking
for permission to complete the NTFS driver in Linux, and the fact we annouced
MANOS, Microsoft has threatened us with legal action if we proceed.  I notified
Microsoft this morning that we are voluntarily dissolving our NTFS Technology
license and as of this moment we have returned all Microsoft materials in our
possession to them, and our attorney have audited and sent a certified notice
to Microsoft telling them we are no longer in possession of their stuff.  They
are boiling mad because we withdrew the NDS source base from Linux and NT.  I
wanted to send out a press release, but they are more dangerous than Novell.   

As of today, TRG is officially available for NTFS file system work on Linux and
MANOS.  I will use the NWFS LRU core with an NTFS decode beneath for the
on-disk structures.  The structure of the cache manager in NT does not exist in
Linux, but I can replicate it with the NWFS LRU to allow Linux to at least
equal their numbers.   We elected to dissolve the agreement because we do not
want Microsoft to claim we used any of their IP in Linux when NTFS shows up.  

The NTFS core we had been using we wrote from scratch, but was based on their
IP, so we were required to delete it as a condition of the agreements.  We are
writing another, which is made easier since we have already written one once. 
TRG has no further obligations to Microsoft, and beyond an ISV relationship,
our relationship with them is dissolved.  

I will post dates for our NTFS R/W sometime next month after we figure out how
long it will take to implement a "clean room" NTFS.  Technically, since the
agreement they had with us was an "exclusive dealing arrangement", the DOJ case
mayb require Microsoft be required to disclose any information in our
possession to the public -- which may be another reason for their sudden,
irrational behavior.

Very Truly Yours,

Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
