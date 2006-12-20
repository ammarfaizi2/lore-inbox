Return-Path: <linux-kernel-owner+w=401wt.eu-S1030222AbWLTSCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWLTSCi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 13:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWLTSCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 13:02:38 -0500
Received: from smtpauth03.prod.mesa1.secureserver.net ([64.202.165.183]:33104
	"HELO smtpauth03.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030222AbWLTSCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 13:02:37 -0500
Message-ID: <45897ABA.3080304@seclark.us>
Date: Wed, 20 Dec 2006 13:02:34 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost>	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>	 <45876C65.7010301@yahoo.com.au>	 <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>	 <45878BE8.8010700@yahoo.com.au>	 <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>	 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>	 <4587B762.2030603@yahoo.com.au>	 <Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>	 <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>	 <Pine.LNX.4.64.0612191037291.3483@woody.osdl.org> <1166563828.10372.162.camel@twins>
In-Reply-To: <1166563828.10372.162.camel@twins>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:

>On Tue, 2006-12-19 at 10:59 -0800, Linus Torvalds wrote:
>  
>
>>On Tue, 19 Dec 2006, Linus Torvalds wrote:
>>    
>>
>>> here's a totally new tangent on this: it's possible that user code is 
>>>simply BUGGY. 
>>>      
>>>
>
>I'm sad to say this doesn't trigger :-(
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi all,

I ran it a number of times on 2.6.16-1.2115_FC4 and always got
 ./a.out | od -x
0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
0000020 aaaa aaaa 5555 5555 5555 5555 5555 5555
0000040 5555 5555 5555 5555

but running it on 2.6.19-rc5 I always get zeros in the middle.

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



