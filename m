Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293436AbSCEQfU>; Tue, 5 Mar 2002 11:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293437AbSCEQfL>; Tue, 5 Mar 2002 11:35:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62989 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293436AbSCEQfA>; Tue, 5 Mar 2002 11:35:00 -0500
Message-ID: <3C84F449.8090404@zytor.com>
Date: Tue, 05 Mar 2002 08:37:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <200203051443.JAA02111@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> hpa@zytor.com said:
> 
>>This is not necessarily a bad thing, however.  If the user hadn't set
>>up  enough swap, they're probably better off getting the error message
>>early. 
>>
> 
> This is not a situation in which a lack of swap or a lack of RAM is a problem.
> 
> The problem is a tmpfs filling up.
> 
> You think that UML refusing to run if it can't get every bit of memory it
> might ever need is preferable to UML running fine in somewhat less memory?
> 

Actually, yes, esp. since the only case you have been able to bring up is 
one of the sysadmin being a moron.

	-hpa


