Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280293AbRKSRRZ>; Mon, 19 Nov 2001 12:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280254AbRKSRRT>; Mon, 19 Nov 2001 12:17:19 -0500
Received: from james.kalifornia.com ([208.179.59.2]:42110 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S280293AbRKSRRG>; Mon, 19 Nov 2001 12:17:06 -0500
Message-ID: <3BF93E36.5040603@blue-labs.org>
Date: Mon, 19 Nov 2001 12:15:34 -0500
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011119
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
CC: vda@port.imtp.ilyichevsk.odessa.ua, James A Sutherland <jas88@cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <200111191647.KAA36330@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>I know. I'd like to hear anybody who have a directory with r!=x
>>on purpose (and quite curious on that purpose). UNIX gugus, anybody?
>>
>
>It's used to hide files in anonymous FTP for for one. It prevents you from
>retrieving files that you don't know the name of. Yes, a brute force attempt
>to open MAY work to find the unknown file, it will take a long time, and you
>are most likely to be detected. The anonymous FTP use is usually in an incoming
>directory - the files are put there from remote individuals, and are hidden
>(unless someone is a good guesser/or a poor name chosen) until the
>administrator examines/moves them.
>

I use it for more than just ftp.  I chmod 710 ~ and have ~ in the 
web/email groups.  It stops prying eyes unless they know what the 
filename is.

David

