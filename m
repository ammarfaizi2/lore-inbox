Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTK1RX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 12:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTK1RX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 12:23:26 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:50305 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262731AbTK1RXY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:23:24 -0500
Message-ID: <3FC7845E.1080800@nortelnetworks.com>
Date: Fri, 28 Nov 2003 12:22:38 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
Cc: szepe@pinerecords.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       root@chaos.analogic.com
Subject: Re: BUG (non-kernel), can hurt developers.
References: <UTC200311281029.hASATvD16681.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>        The routine handler must be very careful, since processing
>        elsewhere  was  interrupted at some arbitrary point. POSIX
>        has the concept of "safe function".  If  a  signal  inter­
>        rupts  an  unsafe  function,  and  handler calls an unsafe
>        function, then the behavior is undefined.  Safe  functions
>        are listed explicitly in the various standards.  The POSIX
>        1003.1-2003 list is

<snip>

You may also want to mention the SUS async-safe list as well, since 
there are some additional functions there.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

