Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269628AbRHMAt3>; Sun, 12 Aug 2001 20:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269621AbRHMAtS>; Sun, 12 Aug 2001 20:49:18 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:38047 "EHLO
	inet-mail4.oraclecorp.com") by vger.kernel.org with ESMTP
	id <S269633AbRHMAtP>; Sun, 12 Aug 2001 20:49:15 -0400
Message-ID: <3B772491.3E33C5CF@oracle.com>
Date: Mon, 13 Aug 2001 02:51:30 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-pre1 unresolved symbols in fat.o/smbfs.o
In-Reply-To: <Pine.LNX.4.33.0108121735510.1228-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 13 Aug 2001, Alan Cox wrote:
> >
> > Oops my fault. My kernel/ksyms goes
> >
> > EXPORT_SYMBOL(vfs_unlink);
> > EXPORT_SYMBOL(vfs_rename);
> > EXPORT_SYMBOL(vfs_statfs);
> > EXPORT_SYMBOL(generic_file_llseek);
> > EXPORT_SYMBOL(generic_read_dir);
> > EXPORT_SYMBOL(__pollwait);
> > EXPORT_SYMBOL(poll_freewait);
> >
> > If you edit yours and drop that line in then rebuild from clean all should
> > be well
> 
> Hmm.. You should probably also add "no_llseek" there..

Don't know about that, but Alan's suggested fix is enough for
 a clean 2.4.9-pre1 build here. Thanks,

--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
