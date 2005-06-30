Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVF3EsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVF3EsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 00:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVF3EsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 00:48:08 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:36012 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262808AbVF3EsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 00:48:03 -0400
Message-ID: <42C37988.2020605@namesys.com>
Date: Wed, 29 Jun 2005 21:48:08 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<42C3615A.9020600@namesys.com> <871x6kv4zd.fsf@evinrude.uhoreg.ca>
In-Reply-To: <871x6kv4zd.fsf@evinrude.uhoreg.ca>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan wrote:

>On Wed, 29 Jun 2005 20:04:58 -0700, Hans Reiser <reiser@namesys.com> said:
>
>  
>
>>Ross Biro wrote:
>>    
>>
>>>How is directories as files logically any different than putting all
>>>data into .data files and making all files directories (yes you would
>>>need some sort of special handling for files that were really called
>>>.data).
>>>      
>>>
>
>  
>
>>Add to this that you make .data the default if the file within the
>>directory is not specified,
>>    
>>
>
>It's sort of like the way web servers handle index.html, for those who
>think it's a stupid idea.  (Of course, some people may still think it's
>a stupid idea... ;-) )
>
>  
>
Good analogy.

>>and define a stanadard set of names for metafiles, and you've got the
>>essential idea, and any differences are details.
>>    
>>
>
>  
>

