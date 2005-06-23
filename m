Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVFWWMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVFWWMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVFWWIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:08:49 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:49681 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262769AbVFWWEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:04:32 -0400
Message-ID: <42BB31E9.50805@slaphack.com>
Date: Thu, 23 Jun 2005 17:04:25 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
In-Reply-To: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Horst von Brand wrote:
> David Masover <ninja@slaphack.com> wrote:
> 
>>Hans Reiser wrote:
>>
>>>Jeff Garzik wrote:
> 
> 
> [...]
> 
> 
>>>You missed his point.  He is saying ext3 code should migrate towards
>>>becoming reiser4 plugins, and reiser4 should be merged now so that the
>>>migration can get started.
> 
> 
>>Sort of.
>>
>>I think ext3 would be nice as a reiser4 plugin.
> 
> 
> What for? It works just fine as it stands, AFAICS.

So does DOS.  Do you use DOS?  I don't even use DOS to run DOS programs.

"Ain't broke" is the battle cry of stagnation.

But, there are some things Reiser does better and faster than ext3, even
if you don't count file-as-directory and other toys.  There's nothing
ext3 does better than Reiser, unless you count the compatibility with
random bootloaders and low-level tools.

>>                                                Not everyone will want
>>to reformat at once, but as the reiser4 code matures and proves itself
>>(even more than it already has),
> 
> 
> I for one have seen mainly people with wild claims that it will make their
> machines much faster, and coming back later asking how they can recover
> their thrashed partitions...

You know how many I've had thrashed on Reiser4?  Two.  The first one was
with a VERY early alpha/beta, and the second one was when I dropped a
laptop and the disk failed.

And it does make certain things faster.  For one thing, "emerge sync" on
Gentoo is twice to four times as fast, and /usr/portage is 75% as big,
as on ReiserFS (3).

>>                                 the ext3 people may find themselves
>>wanting some of the more generic optimizations.
> 
> 
> They'll filch them in due time, don't worry.

Duplication of effort.  With plugins, we can optimize the upper layers
of ALL filesystems, regardless of the lower layers, in such a way that
it is optional.  I'm sure it's far easier to write a Reiser storage
plugin than a brand new FS.

Eventually, once competition is only based on storage format, we could
end up with just one format.  Just one filesystem!  (except for
fat/ntfs/iso/udf/network...)  And in the open source world, sometimes a
single product is a good thing.

>>But, I don't think that will realistically happen at all.
>>
>>Instead, what will probably happen is that once Reiser4 is in the
>>mainstream kernel, it will become more popular and noticable.  Other
>>FSes will take note.  ext3 people may decide they want
>>file-as-directory,
> 
> 
> That idea is even much older than Linux itself, and no other (Unix)
> filesystem has implemented it. Ever. Wonder why...
> 
> 
>>                   and vfat people may decide they want cryptocompress,
> 
> 
> I'm sure they don't, because it is mostly for Windows and assorted devices
> (pendrives, digital cameras, ...) compatibility.

I, for one, would like to use a pendrive and have certain files be
encrypted transparently, only for use on Linux, but others be ready to
transfer to a Windows box.

>>Eventually, with all the features ported, we end up with a situation
>>where there may be no meaningful difference between a filesystem and a
>>low-level reiser4 plugin.
> 
> 
> Could very well take decades, if ever.

How would you do it, in a way that doesn't take decades?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQrsx6HgHNmZLgCUhAQKXYw//Z9bSh74AWr2o1n+EM0nCHUNV78xgeuey
ZHtzUT8rCv2KQ+2fMe5EnRUaRYTKvFnnGccH4vu/OAArqKqt/RgP3NP8UZALsZbB
MMoEHZSX/E0BFlKKiBjPgvwfnnY9ZYF0GPkU5L97dj1K0dEQMndOZoYDV07H4TnN
/1VkytnsXuhm5nqRhPd89rDbvQtXpzHiDjVNPfT+J6M6JFw8jfYQZ0Fo1T9dVKMg
qibVneJj+onHVBmBBqGTZ0Ane5VmG0h0a2ZwsslQPkf03DAgprliykr40NCECdli
OdaS73qYPlYRRl1nuw84g2KOLXbTnSGmW1t4qt/tyI6t3TOEn9FqY7YzwvbWIVLP
GMkJG1htAQefGNcEXx+15xAHJi6/0DiSoJu+P+ie+yG8pkG943936AxEgs89pTpC
z8i/GV9Uq+S6BgA+RJuxpk6U8rQ0YHMhAiK83p+s7vdUsGIKomUmSbn7a6DC7cZt
aGkqxYyaoV2MlHUMUebSv5F82JUgx6rPuc8SQW1wvVIVdNA7QhlYYsPa5vFFj34C
scxN9vNGyxWGu60yKx7LSYRkB9/prJytKvpezVKRkn8pnKnl4AHodKioSPxt1iHC
BvNsLL8Kn8FBe/HG98d1v8vwTqe0Y8KgBMRe/J73u/OzU82lh2V3YbXNaW+DLVGz
MOaHYEzfoNg=
=yFsv
-----END PGP SIGNATURE-----
