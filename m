Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbULOFTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbULOFTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 00:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbULOFTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 00:19:32 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:33473 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261887AbULOFT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 00:19:27 -0500
Message-ID: <41BFC964.2070301@namesys.com>
Date: Tue, 14 Dec 2004 21:19:32 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>	 <41ACA7C9.1070001@namesys.com>	 <1103043518.21728.159.camel@pear.st-and.ac.uk>	 <41BF21BC.1020809@namesys.com> <1103059622.2999.17.camel@grape.st-and.ac.uk>
In-Reply-To: <1103059622.2999.17.camel@grape.st-and.ac.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Foldiak wrote:

>On Tue, 2004-12-14 at 17:24, Hans Reiser wrote:
>  
>
>>Peter, I think you are right, though it might be useful to have the 
>>default be dirname/..../glued and to allow users to link 
>>dirname/..../filebody to 
>>dirname/..../something_else_if_they_want_it_to_not_be_glued, and to have 
>>dirname/..../filebody or whatever it is linked to be what they get if 
>>they read the directory as a file.
>>    
>>
>
>Yes. I assume you mean that dirname in itself should always be
>interpreted as dirname/..../glued, which by default would be a linked to
>dirname/..../filebody, the latter being the file content, right?
>  
>
reversed:

dirname in itself should always be
interpreted as dirname/..../filebody, which by default would be a linked to
dirname/..../glued, 

>Also, a pseudofile (e.g. dirname/..../structure ?) could be used to
>specify how the files should be glued together. A simple question is,
>for instance, what separators to use between the components, and what
>ordering to use when putting the component objects together. (This
>pseudofile could also determine more complicated ways of composing
>objects.) 
>  
>
Could be cool.

>The component objects themselves could be full objects, so they
>themselves could have sub-components.
> Peter
>
>
>
>  
>

