Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268015AbUH1WMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268015AbUH1WMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUH1WMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:12:55 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:55187 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266362AbUH1WMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:12:50 -0400
Message-ID: <41310364.8070302@namesys.com>
Date: Sat, 28 Aug 2004 15:12:52 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alexander G. M. Smith" <agmsmith@rogers.com>
CC: Will Dyson <will_dyson@pobox.com>, akpm@osdl.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: Separating Indexing and Searching (was silent semantic changes
 with reiser4)
References: <584702172685-BeMail@cr593174-a>
In-Reply-To: <584702172685-BeMail@cr593174-a>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander G. M. Smith wrote:

>
>
>However, one of my (unfinished) experiments was to have magic directories that show query results as their contents.  One attribute of the directory (or even its name) would be the query string.  That way even old software (like "ls") could use queries!  Implementing queries-as-directories might require moving some things back into the kernel, or at least into some plug-in level.
>
>- Alex
>
>
>  
>
Symlinks also.  Symlinks with powerful queries in them would require a 
parser in the kernel.  Thanks for helping me to distill my incoherent 
reasons for the parser being in the kernel.
