Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUIAVSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUIAVSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUIAVPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:15:33 -0400
Received: from [209.195.52.120] ([209.195.52.120]:15572 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S268086AbUIAVOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:14:14 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jeremy Allison <jra@samba.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
Date: Wed, 1 Sep 2004 14:09:11 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040901203101.GG31934@mail.shareable.org>
Message-ID: <Pine.LNX.4.60.0409011408270.3260@dlang.diginsite.com>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com>
 <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua>
 <1093789802.27932.41.camel@localhost.localdomain> <1093804864.8723.15.camel@lade.trondhjem.org>
 <20040829193851.GB21873@jeremy1> <20040901201945.GE31934@mail.shareable.org>
 <20040901202641.GJ4455@legion.cup.hp.com> <20040901203101.GG31934@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what happens when you ue one of the many software packages around that 
lets windows access a NFS server. when you copy the file to a NFS accessed 
drive does it loose part of the data?

David Lang

  On Wed, 1 Sep 2004, Jamie Lokier 
wrote:

> Date: Wed, 1 Sep 2004 21:31:01 +0100
> From: Jamie Lokier <jamie@shareable.org>
> To: Jeremy Allison <jra@samba.org>
> Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
>     Alan Cox <alan@lxorguk.ukuu.org.uk>,
>     Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
>     Rik van Riel <riel@redhat.com>, Christer Weinigel <christer@weinigel.se>,
>     Spam <spam@tnonline.net>, Andrew Morton <akpm@osdl.org>,
>     wichert@wiggy.net, Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com,
>     hch@lst.de, Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
>     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
>     reiserfs-list@namesys.com
> Subject: Re: silent semantic changes with reiser4
> 
> Jeremy Allison wrote:
>>> Streams in a Word file?
>>
>> Yep.
>>
>>> Are you saying that when I copy a .doc file onto my Linux box and off,
>>> I lose part of a Word document?
>>
>> Right now no, because when Samba refuses the stream open, Word falls
>> back into a "tar"-like mode where it linearises the streams into the
>> data (it's a legacy mode for storing data on a FAT drive, not an NTFS
>> drive). However, the problem is that no currently supported Microsoft
>> OS doesn't have streams-capable NTFS support.
>
> I meant when I copy not using Samba.  For example, I copy the .doc
> file in Windows NT to an FTP server.
>
> Does the FTP operation magically linearise the .doc streams on demand?
>
> Or does FTP lose part of the Word document?
>
> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
