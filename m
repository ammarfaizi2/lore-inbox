Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269742AbUH0A7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269742AbUH0A7D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269834AbUH0A4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:56:36 -0400
Received: from community21.interfree.it ([213.158.70.80]:42923 "EHLO
	community21.interfree.it") by vger.kernel.org with ESMTP
	id S269830AbUH0AC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:02:27 -0400
Date: Fri, 27 Aug 2004 02:00:06 +0200
From: Stelian Ionescu <carlomalone@interfree.it>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Andrew Morton <akpm@osdl.org>, jra@samba.org, torvalds@osdl.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827000006.GA6970@universe.org>
Reply-To: carlomalone@interfree.it
Mail-Followup-To: Wichert Akkerman <wichert@wiggy.net>,
	Andrew Morton <akpm@osdl.org>, jra@samba.org, torvalds@osdl.org,
	reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com,
	reiserfs-list@namesys.com
References: <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net> <m3llg2m9o0.fsf@zoo.weinigel.se> <1906433242.20040826133511@tnonline.net> <20040826113332.GL2612@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
In-Reply-To: <20040826113332.GL2612@wiggy.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:33:32PM +0200, Wichert Akkerman wrote:
>Previously Spam wrote:
>>   How  so?  The whole idea is that the underlaying OS that handles the
>>   copying  should  also  know  to  copy  everything, otherwise you can
>>   implement  everything  into  applications  and  just  skip the whole
>>   filesystem part.
>
>UNIX doesn't have a copy systemcall, applications copy the data
>manually.
couldn't sendfile(2) be used for that ?
perhaps a flag parameter could be added to sendfile(2) which specifies
whether to copy _all_ metadata if both fd's correspond to files, something
like either O_METADATA or O_NOMETADATA

-- 
Stelian Ionescu aka fe[nl]ix

Quidquid latine dictum sit, altum viditur.
