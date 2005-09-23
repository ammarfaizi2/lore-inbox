Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVIWGV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVIWGV1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 02:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVIWGV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 02:21:26 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:19335 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750706AbVIWGV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 02:21:26 -0400
Message-ID: <43339EE5.9030202@dgreaves.com>
Date: Fri, 23 Sep 2005 07:21:25 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gmaxwell@gmail.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@suse.cz>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>	 <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz>	 <20050921000425.GF6179@thunk.org> <e692861c05092018017ceef484@mail.gmail.com>
In-Reply-To: <e692861c05092018017ceef484@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:

>Very interesting indeed, although it almost seems silly to tackle the
>difficult problem of making filesystems highly robust against oddball
>failure modes while our RAID subsystem falls horribly on it's face in
>the fairly common (and conceptually easy to handle) failure mode of a
>raid-5 where two disks have single unreadable blocks on differing
>parts of the disk. (the current raid system hits one bad block, fails
>the whole disk, then you attempt a rebuild and while reading hits the
>other bad block and downs the array).
>  
>
who's not keeping up with the linux-raid list then ;)

David
PS I'm sure assistance would be appreciated in testing and reviewing
this few day old feature - or indeed the newer 'add a new disk to the
array' feature.

