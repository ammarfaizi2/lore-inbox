Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269849AbUH0ANX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269849AbUH0ANX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269828AbUH0AHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:07:25 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:22480 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269829AbUH0ACQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:02:16 -0400
Message-ID: <412E7A08.5070005@namesys.com>
Date: Thu, 26 Aug 2004 17:02:16 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>
>
>In my opinion we shouldn't merge file-as-a-directory
>semantics into the kernel until we figure out how to
>fix the backup/restore problem and keep standard unix
>utilities work.
>
>  
>
One incremental piece at a time our solution will fall into place.  
Pieces should go in when they are individually ready.  Warning users 
that some pieces might be changed out from under them up until when 2.8 
ships is ok with me though.
