Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292000AbSBAUuE>; Fri, 1 Feb 2002 15:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292012AbSBAUt6>; Fri, 1 Feb 2002 15:49:58 -0500
Received: from atlante.atlas-iap.es ([194.224.1.3]:21770 "EHLO
	atlante.atlas-iap.es") by vger.kernel.org with ESMTP
	id <S292000AbSBAUtt>; Fri, 1 Feb 2002 15:49:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: O_DIRECT fails in some kernel and FS
Date: Fri, 1 Feb 2002 21:49:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au>
In-Reply-To: <3C5AFE2D.95A3C02E@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Wkcm-0005D4-00@antoli.uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/02 21:44, Andrew Morton wrote:
> Ricardo Galli wrote:
> > After some comments from Oliver Diedrich (editor of heise.de), which told
> > me he couldn't make O_DIRECT work on 2.4.17, I tried with different
> > versions and file systems:
> >
> > This is the result:
> >
> > 2.4.14 - Ext[23] - redhat7.2 glibs: OK (at least the bytes are written)
> > 2.4.17 - ReiserFS - Debian Sid    : FAILS (0 bytes file, write returns
> > -1) 2.4.17 - Ext2 - Debian Woody      : OK (bytes written)
> > 2.4.17 - Ext3 - Debian Woody      : FAILS (0 bytes file, write returns
> > -1)
> >
> > Oliver Diedrich also told he could make work O_DIRECT with ext3 and
> > 2.4.17.
> >
> > Is this normal? Does it really work on 2.4.14? Or it doesn't but the
> > kernel doesn't avoid caching?
>
> ext2 is the only filesystem which has O_DIRECT support.

Does that mean that the succesful test with ext3 and 2.4.14 is bogus?


-- 
  ricardo
"I just stopped using Windows and now you tell me to use Mirrors?" 
    - said Aunt Tillie, just before downloading 2.5.3 kernel.
