Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264747AbSJUFif>; Mon, 21 Oct 2002 01:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSJUFif>; Mon, 21 Oct 2002 01:38:35 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:31249 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264747AbSJUFid>; Mon, 21 Oct 2002 01:38:33 -0400
Message-ID: <3DB39446.5010402@namesys.com>
Date: Mon, 21 Oct 2002 09:44:38 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: landley@trommello.org
CC: linux-kernel@vger.kernel.org, boissiere@nl.linux.org
Subject: Re: Crunch time -- Final merge candidates for 3.0 (the list).
References: <200210201849.23667.landley@trommello.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We will send Reiser4 out soon, probably around the 27th.

Hans

Rob Landley wrote:

>Okay, Linus has left for the Linux Lunacy Cruise (see www.geekcruises.com), 
>which ends october 27.  When he gets back, he's implied that there will be 
>EXACTLY ONE more set of last minute merges before we switch over to the 
>3.0-pre (or 2.6-pre) series.  Those of you waiting for the last minute: this 
>is it.
>
>There are people patch-hoovering while Linus is off "lecturing" on a boat in 
>the carribean, but we don't know who those are, so that's not useful.  What 
>IS useful is knowing what the candidate patches are.  Not bug fixes, but new 
>features with one final shot at 2.5.45.
>
>The October 19 entry from Guillaume Boissiere's 2.5 status list 
>(http://kernelnewbies.org/status/) has the following entries in the "ready 
>for merging" state:
>
>=====================================================
>
>o in -ac PCMCIA Zoom video support (Alan Cox) 
>http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.1/0326.html
>
>o in -ac Device mapper for Logical Volume Manager (LVM2)  (LVM2 team) 
>http://www.sistina.com/products_lvm.htm
>
>o in -mm VM large page support  (Many people) 
>http://lse.sourceforge.net/
>
>o in -mm  Page table sharing  (Daniel Phillips, Dave McCracken) 
>http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
>(or possibly here:)
>http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html
>
>o Ready - Build option for Linux Trace Toolkit (LTT) (Karim Yaghmour) 
>http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0832.html
>
>o Ready - Dynamic Probes (dprobes team) 
>http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes
>
>o Ready - Zerocopy NFS (Hirokazu Takahashi) 
>http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0429.html
>
>o Ready - High resolution timers (George Anzinger, etc.) 
>http://high-res-timers.sourceforge.net/
>
>o Ready - EVMS (Enterprise Volume Management System) (EVMS team) 
>http://sourceforge.net/projects/evms
>
>o Ready - Linux Kernel Crash Dumps (Matt Robinson, LKCD team) 
>http://lkcd.sourceforge.net/
>
>o Ready - Rewrite of the console layer (James Simmons) 
>http://linuxconsole.sourceforge.net/
>
>To the above can be added the following recent submission on the list:
>
>o Ready- Kexec, luanch ELF format linux kernel from Linux (Eric W. Biederman)
>http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html
>
>=================================================
>
>That's currently it, that I'm aware of.  If your patch isn't on that list, and 
>getting testing by people on linux-kernel (and getting a bunch of satisifed 
>users to go "worked for me!" at it), then you should speak up and GET it on 
>that list, or wait for the next development series.
>
>When Linus comes back, at best he's going to give a thumbs up or thumbs down 
>to each patch currently sitting there in front of him, and then it's on to 
>the feature freeze.  He may not take any of them, or he may just take one or 
>two.  But the best we can hope to do is present him with a nice (short) list 
>of tested patches. (Remember, the less work Linus has to do, the higher the 
>percentage of it that will actually get done.)
>
>So everybody, try the above patches.  If they work for you, say so on this 
>list.  It's no guarantee, but Linus has said endorsements from testers can 
>make him feel more comfortable about a patch.  Possibly we can collect a list 
>of names of people for whom a patch "worked for me", to add to the list.
>
>If your patch isn't on the list, speak out now.  Better yet, post a URL to the 
>latest version.  It's "show me the code" time.  (Yes, Hans Reiser, this means 
>you. :)  There are still 7 days till the end of Linus's cruise, but that's 
>not much time to get guinea pigs to publicly pipe up with a hearty "AOL!" of 
>support for your work...
>
>Again, some of the things on this list won't make it into 3.0.  It's just 
>candidates.  But everything that is NOT on this list in about 7 days is 
>probably going to become 3.1 material by default.
>
>Speak now, or till 3.1 hold your peace...
>
>Rob
>
>P.S.  If somebody wants to put together a tree integrating some or all of the 
>above, ala Folk/Wolk, it might be useful for testing purposes.  Good idea to 
>find conflicts now, eh?
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



