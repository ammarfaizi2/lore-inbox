Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276098AbRI1O52>; Fri, 28 Sep 2001 10:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276103AbRI1O5N>; Fri, 28 Sep 2001 10:57:13 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:45840 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S276099AbRI1O4V>; Fri, 28 Sep 2001 10:56:21 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15284.36676.918419.684442@beta.reiserfs.com>
Date: Fri, 28 Sep 2001 18:55:00 +0400
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: <linux-kernel@vger.kernel.org>,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: weirdness in reiserfs
In-Reply-To: <Pine.LNX.4.33.0109281509080.10065-100000@nick.dcs.qmul.ac.uk>
In-Reply-To: <Pine.LNX.4.33.0109281509080.10065-100000@nick.dcs.qmul.ac.uk>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Bernstein writes:
 > I have a 240GB reiserfs ataraid partition on one of my servers (2.4.9-ac10
 > + ext3 0.9.9 + ext3 speedup + ext3 "experimental VM patch" + jfs 1.0.4),
 > which I had populated with lots of little files, probably huge amounts of
 > tail-packing going on.
 > 
 > I deleted a tarball of one of my directories; I forget how big the file
 > was, but I reckon it was of the order of 25GB. It took long enough (over
 > an hour) that I went to the pub with fingers crossed instead of nursing
 > it. While it was deleting vmstat 1 was showing bi= ~ 2000 and bo= ~ 20000,
 > so it was hammering away. Fine, I thought, it's a big file; I don't do
 > this sort of thing often, maybe the stuff needed to delete such a big file
 > is bigger than the journal size or something. But.. the partition was
 > otherwise inaccessible with processes just blocking. Oddly df worked
 > though, so I could watch my use of the filesystem going down!

Were there reiserfs-related messages in the kernel log?

 > 
 > So.. I came back in this morning and things had recovered. Weird. Could
 > the "experimental VM patch" mentioned on the ext3 for 2.4 page be a little
 > too experimental? Sorry to be so vague...
 > 
 > Matt

Nikita.

 > 
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
