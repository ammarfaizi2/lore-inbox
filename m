Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269837AbUH0AEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269837AbUH0AEB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269803AbUHZX7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:59:23 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:54696 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269705AbUHZXza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:55:30 -0400
Message-ID: <412E786E.5080608@namesys.com>
Date: Thu, 26 Aug 2004 16:55:26 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <20040825152805.45a1ce64.akpm@osdl.org>	 <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org>	 <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de>	 <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de>	 <1093526273.11694.8.camel@leto.cs.pocnet.net>	 <20040826132439.GA1188@lst.de>	 <1093527307.11694.23.camel@leto.cs.pocnet.net>	 <20040826134034.GA1470@lst.de> <1093528683.11694.36.camel@leto.cs.pocnet.net>
In-Reply-To: <1093528683.11694.36.camel@leto.cs.pocnet.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:

>
>
>I don't know, ask Hans. How could the VFS know it a filesystem wants to
>do something specific with a file that is completely transparent to the
>VFS?
>
>  
>
To know what method to use, you must determine the pluginid, and then 
find the method within that plugin for that vfs operation.

As for overhead, well, who eats whose dust in the benchmarks....?
