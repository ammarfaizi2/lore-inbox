Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUH0Mch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUH0Mch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUH0Map
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:30:45 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:29714 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S264261AbUH0M3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:29:07 -0400
Message-ID: <412F2A09.7050104@hist.no>
Date: Fri, 27 Aug 2004 14:33:13 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: riel@redhat.com, mikulas@artax.karlin.mff.cuni.cz, torvalds@osdl.org,
       hch@lst.de, reiser@namesys.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408252052420.13240-100000@chimarrao.boston.redhat.com>	<412D968B.9030107@hist.no> <20040826022137.1504ffb7.pj@sgi.com>
In-Reply-To: <20040826022137.1504ffb7.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

>Helge wrote:
>  
>
>>So an old "tar" won't get this right as it will assume that an object
>>is either file or directory.
>>    
>>
>
>There are many backup apps, not just one.  I've written a few myself,
>none of which will ever be worthy of notice.  The sourceforge
>Topic.System.Archiving.Backup lists 335 projects at present.
>
>I find the idea that most backup tools and scripts will silently
>stop working correctly to be pretty scary.  
>  
>
They won't stop working, they will merely not support
the new features.  That is only a problem if
you actually use those features.  If all you have
is plain files and plain directories - no problem.  Not
if files-as-directories are implemented right.

Helge Hafting
