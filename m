Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319401AbSILBic>; Wed, 11 Sep 2002 21:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319403AbSILBib>; Wed, 11 Sep 2002 21:38:31 -0400
Received: from packet.digeo.com ([12.110.80.53]:54702 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319401AbSILBib>;
	Wed, 11 Sep 2002 21:38:31 -0400
Message-ID: <3D7FF4C7.BF2DA2F9@digeo.com>
Date: Wed, 11 Sep 2002 18:58:31 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
CC: linux-kernel@vger.kernel.org
Subject: Re: Heuristic readahead for filesystems
References: <200209112104.41987.oliver@neukum.name> <Pine.LNX.3.95.1020911151848.32205A-100000@chaos.analogic.com> <20020912004520.GD10315@pegasys.ws>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 01:43:12.0254 (UTC) FILETIME=[C12FF9E0:01C259FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> 
> ...
> Gating back to the original issue which was "readahead" of
> stat() info...
> 

ext3 does directory readahead.  ext2 does not.  If someone can
demonstrate any advantage which ext3 gets from this, we can put
it back into ext2 as well.

inode readahead would be pretty simple to do.
