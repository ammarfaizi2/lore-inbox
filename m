Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312304AbSCYFv2>; Mon, 25 Mar 2002 00:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312305AbSCYFvS>; Mon, 25 Mar 2002 00:51:18 -0500
Received: from [211.238.181.68] ([211.238.181.68]:17683 "EHLO
	mail.digitaldreamstudios.net") by vger.kernel.org with ESMTP
	id <S312304AbSCYFvA>; Mon, 25 Mar 2002 00:51:00 -0500
Message-ID: <3C9EBACC.1640A37E@nownuri.net>
Date: Mon, 25 Mar 2002 14:51:08 +0900
From: SeongTae Yoo <alloying@nownuri.net>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>, linux-kernel@vger.kernel.org
Subject: Re: file listing problem in smbfs, kernel 2.4.18
In-Reply-To: <Pine.LNX.4.44.0203191959310.27806-100000@cola.teststation.com> <3C97E1D2.369C6A10@nownuri.net>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SeongTae Yoo wrote:
> 
> Urban Widmark wrote:
> >
> > On Tue, 19 Mar 2002, SeongTae Yoo wrote:
> >
> > > Urban Widmark wrote:
> > > >
> > > > You could also try the smbfs unicode patch for 2.4.18, and see if that
> > > > changes anything.
> > > >     http://www.hojdpunkten.ac.se/054/samba/index.html
> > > >     (Note the additional samba patch and mount flags needed)
> > >
> > > I tried it just before, but same result.
> >
> > And you patched samba, enabled unicode with the unicode flag and set the
> > "codepage" to be unicode?
> > (I know, it's a bad interface)
> 
> My mistake! Although I have read your patch page, the w2k ntfs partition is
> mounted in the normal options. When they are mounted with enabled unicode
> option, it seems to be listed very well.
> 
> After some other tests (depth change, other directories with the same problem,
> fat32 partition, etc), I will post the results.

It seems that the problem of file listing is solved in my case.

Thanks.
