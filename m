Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281051AbRKYUiF>; Sun, 25 Nov 2001 15:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281052AbRKYUh4>; Sun, 25 Nov 2001 15:37:56 -0500
Received: from james.kalifornia.com ([208.179.59.2]:39213 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S281051AbRKYUhj>; Sun, 25 Nov 2001 15:37:39 -0500
Message-ID: <3C015681.8080006@blue-labs.org>
Date: Sun, 25 Nov 2001 15:37:21 -0500
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Josep Lladonosa i Capell <jep@jep.net.dhis.org>
CC: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.16-pre1 not compiling without SMP
In-Reply-To: <3C013407.7C639D34@jep.dhis.org> <20011125192156.A7274@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After you have enabled SMP in a past configuration, to compile without 
SMP, you must do a 'make distclean'.  It's a bug in the current config 
stuff that hasn't ever been addressed.

David

Francois Romieu wrote:

>Josep Lladonosa i Capell <jep@jep.net.dhis.org> :
>[...]
>
>>just the subject :-)
>>
>
>Compiled fine here. Check your tree/config and provide more info (.config,
>compiler, message) if the problem persists. The file REPORTING-BUGS gives
>some hints.
>


