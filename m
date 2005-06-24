Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVFXSQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVFXSQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 14:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbVFXSQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 14:16:32 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:63691 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262264AbVFXSQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 14:16:19 -0400
Message-ID: <42BC4DF5.3030904@namesys.com>
Date: Fri, 24 Jun 2005 11:16:21 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: Alexander Zarochentcev <zam@namesys.com>, Lincoln Dale <ltd@cisco.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com> <42BB7083.2070107@cisco.com> <42BBAD0F.2040802@namesys.com> <20050624071159.GQ29811@parcelfarce.linux.theplanet.co.uk> <42BBCC65.8060709@namesys.com> <20050624144522.GR29811@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050624144522.GR29811@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Fri, Jun 24, 2005 at 02:03:33AM -0700, Hans Reiser wrote:
>  
>
>>Al Viro wrote:
>>
>>    
>>
>>>Have I missed the posting with analysis of changes in locking scheme
>>>and update of proof of correctness?  If so, please give the message ID.
>>>
>>>_That_ had been the major showstopper for any merges, IIRC.
>>> 
>>>
>>>      
>>>
>>Ah, the prince of helpfulness has arrived.
>>
>>Yes, as I remember,
>>    
>>
>
>Kindly put some efforts into remembering the thread that contains e.g.
>http://marc.theaimsgroup.com/?l=linux-kernel&m=109347094309283&w=2
>
>If that work (summary: introduction of hybrid objects invalidates the
>existing locking scheme for directories and that had lead at least to
>several user-exploitable deadlocks described in details in the same
>thread; current proof of correctness is in the tree, see
>Documentation/filesystems/Directory-Locking.txt and at the very least
>it needs to be updated) had been done - please, give the message ID
>of posting with such update.  If not - please, arrange getting it done.
>
>
>  
>
We disabled metafiles until we can fix this.  With no metafiles, the
issue does not exist.

Thanks for your assistance with finding that problem.

Hans
