Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWBHSbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWBHSbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWBHSbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:31:16 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21945 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030435AbWBHSbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:31:16 -0500
Message-ID: <43EA38F0.20107@watson.ibm.com>
Date: Wed, 08 Feb 2006 13:31:12 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
References: <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com> <m1ek2ea0fw.fsf@ebiederm.dsl.xmission.com> <43EA02D6.30208@watson.ibm.com> <20060208180309.GA20418@sergelap.austin.ibm.com>
In-Reply-To: <20060208180309.GA20418@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Hubertus Franke (frankeh@watson.ibm.com):
> 
>>IMHO, there is only a need to refer to a namespace from the global context.
>>Since one will be moving into a new container, but getting out of one
>>could be prohibitive (e.g. after migration)
>>It does not make sense therefore to know the name of a namespace in
>>a different container.
> 
> 
> Not sure I agree.  What if we are using a private namespace for a
> vserver, and then we want to create a private namespace in there for a
> mobile application.  Since we're talking about nested namespaces, this
> should be possible.
> 
> Now I believe Eric's code so far would make it so that you can only
> refer to a namespace from it's *creating* context.  Still restrictive,
> but seems acceptable.
> 

That's what I meant .. as usually used the wrong word..
s/global context/spawing context/g .. because that's the only
place where you have a pid to refer to the newly created container !

> (right?)
> 

Yes, seriii  .. ahmm serue
> -serge
> 


