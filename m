Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267946AbUHZInL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267946AbUHZInL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUHZIji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:39:38 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:26879 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267923AbUHZIgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:36:42 -0400
Message-ID: <412DA11B.2070303@namesys.com>
Date: Thu, 26 Aug 2004 01:36:43 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <Pine.LNX.4.58.0408260204050.22259@artax.karlin.mff.cuni.cz> <Pine.LNX.4.58.0408251723540.17766@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408251723540.17766@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Streams are quite ugly.  However, if you decompose streams into all of 
the little pieces that are needed to emulate them, the pieces are quite 
nice.

For instance, inheriting stat data from a common parent is nice, and 
inheritance is nice, and being able to cat dirname/pseudos/cat and get a 
concatenation of all of the files is nice, and being able to cat 
dirname/pseudos/tar and get an archive of the directory is nice, and, 
well, if you decompose all of the features of streams into little 
features you get a bunch of fun little features much nicer than streams.

Hans
