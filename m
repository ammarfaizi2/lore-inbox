Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSDMRBJ>; Sat, 13 Apr 2002 13:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSDMRBI>; Sat, 13 Apr 2002 13:01:08 -0400
Received: from customer201-108.iplannetworks.net ([200.69.201.108]:36349 "EHLO
	ntmba.mba") by vger.kernel.org with ESMTP id <S288748AbSDMRBH>;
	Sat, 13 Apr 2002 13:01:07 -0400
Message-ID: <3CB863B7.5080109@laotraesquina.com.ar>
Date: Sat, 13 Apr 2002 13:58:31 -0300
From: Pablo Alcaraz <pabloa@laotraesquina.com.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: es-ar, en-us
MIME-Version: 1.0
To: Craig Knox <crg@monster.gotadsl.co.uk>
CC: "Calin A. Culianu" <calin@ajvar.org>, linux-kernel@vger.kernel.org
Subject: Re: Question about 'Hidden' Directories in ext2
In-Reply-To: <Pine.LNX.4.30.0204021704360.6590-100000@rtlab.med.cornell.edu> <20020403104348Z310435-617+3433@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may use tripwire after you clean your system.
Tripwire will check your system for changes in critical files.

Pablo

Craig Knox wrote:

>On Tue, 2002-04-02 at 23:16, Calin A. Culianu wrote:
>
>>Ok, so some hackers broke into one of our boxes and set up an ftp site.
>>They monopolized over 70gb of hard drive space with warez and porn.  We
>>aren't really that upset about it, since we thought it was kind of funny.
>>(Of course we don't like the idea that they are using out bandwidth and
>>disk space, but we can easily remedy that).
>>
>>Anyway, the weird thing is they created 2 directories, both of which were
>>strangely hidden.  You can cd into them but you can't ls them.  I
>>
>>/usr/lib/ypx and /usr/man/ypx were the two directories that contained both
>>the ftp software and the ftp root.  When you are in /usr/man and you do an
>>ls, you don't see the ypx directory (same when you are in /usr/lib).  The
>>ls binary we got is right off the redhat cd so it shouldn't still be
>>compromised by whatever rootkit was installed.
>>
>>My question is this: can the data structures in ext2fs be somehow hacked
>>so a directory can't appear in a listing but can be otherwise located for
>>a stat or a chdir?  I should think no.. maybe we still haven't gotten rid
>>of the rootkit...
>>
>
>If you are using the binary "ls" of the redhat CD they are probably
>using a kernel module to hide this directory.
>Have you tried running -> http://www.chkrootkit.org on the box?
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>


