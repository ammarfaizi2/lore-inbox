Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290743AbSARQ7b>; Fri, 18 Jan 2002 11:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290740AbSARQ7T>; Fri, 18 Jan 2002 11:59:19 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:39842 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S290743AbSARQq5>; Fri, 18 Jan 2002 11:46:57 -0500
Message-ID: <3C485169.7070005@sap.com>
Date: Fri, 18 Jan 2002 17:46:33 +0100
From: Wilhelm Nuesser <wilhelm.nuesser@sap.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: clarification about redhat and vm
In-Reply-To: <E16RFE9-00042W-00@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>"If redhat doesn't use the -aa VM " was a short form of "if redhat
>>cannot see the goodness of all the bugfixing work that happened between
>>the 2.4.9 VM and any current branch 2.4, and so if they keep shipping
>>2.4.9 VM as the best one for DBMS and critical VM apps like the SAP
>>benchmark".
>>
>
>The RH VM is totally unrelated to the crap in 2.4.9 vanilla. The SAP comment
>begs a question. 2.4.10 seems to have problems remembering to actually 
>do fsync()'s. How much of your SAP benchmark is from fsync's that dont
>happen ? Do you get the same values with 2.4.18-aa ?
>
Well, basically we checked the thing many times with quite different 
kernels.
Our current tests - which show exactly the same results as 
2.4.[10,14,15] - run
on the new "official" SuSE kernel 2.4.16.  Again, we  observe a 
performance increase
in high swap situations of about  a factor of ten compared to 2.4.[7,9].
 
IMO, this shows that errors like fsync etc. are _not_ responsible for 
the improved
performance.


But of course, we will check the newer kernels as well.  I think we 
could live with another
factor of ten ...

Best regards
    Willi

-----------------------

   Willi Nüßer
    SAP LinuxLab




