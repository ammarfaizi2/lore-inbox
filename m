Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312980AbSDBWv4>; Tue, 2 Apr 2002 17:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312982AbSDBWvp>; Tue, 2 Apr 2002 17:51:45 -0500
Received: from h53n2fls32o986.telia.com ([213.67.49.53]:28421 "EHLO
	localhost.toothpaste.org") by vger.kernel.org with ESMTP
	id <S312980AbSDBWve>; Tue, 2 Apr 2002 17:51:34 -0500
Date: Wed, 3 Apr 2002 01:48:28 +0200
From: Erik =?ISO-8859-1?Q?Ljungstr=F6m?= <insight@metalab.unc.edu>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about 'Hidden' Directories in ext2
Message-Id: <20020403014828.70850375.insight@metalab.unc.edu>
In-Reply-To: <Pine.LNX.4.30.0204021704360.6590-100000@rtlab.med.cornell.edu>
Organization: Independent C0der
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2002 17:16:42 -0500 (EST)
"Calin A. Culianu" <calin@ajvar.org> wrote:

> 
> Ok, so some hackers broke into one of our boxes and set up an ftp site.
> They monopolized over 70gb of hard drive space with warez and porn.  We
> aren't really that upset about it, since we thought it was kind of funny.
> (Of course we don't like the idea that they are using out bandwidth and
> disk space, but we can easily remedy that).
> 
> Anyway, the weird thing is they created 2 directories, both of which were
> strangely hidden.  You can cd into them but you can't ls them.  I
> 
> /usr/lib/ypx and /usr/man/ypx were the two directories that contained both
> the ftp software and the ftp root.  When you are in /usr/man and you do an
> ls, you don't see the ypx directory (same when you are in /usr/lib).  The
> ls binary we got is right off the redhat cd so it shouldn't still be
> compromised by whatever rootkit was installed.
> 
> My question is this: can the data structures in ext2fs be somehow hacked
> so a directory can't appear in a listing but can be otherwise located for
> a stat or a chdir?  I should think no.. maybe we still haven't gotten rid
> of the rootkit...
> 
> -Calin
> 
> 
> -

This isn't really my area of expertice, but have you also recovered the original crond ? Perhaps that was compromized as well, and a replacement of the binaries are crontabbed? Search your system for copies of ls, netstat, ps, whatever. This is just a thought that hit me when I read this.

I wish you all of luck in recovering your system(s)


--
Best regards, Erik
