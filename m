Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290693AbSARNqH>; Fri, 18 Jan 2002 08:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290694AbSARNps>; Fri, 18 Jan 2002 08:45:48 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:27643 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S290693AbSARNpi>; Fri, 18 Jan 2002 08:45:38 -0500
Message-ID: <3C482739.9498E422@didntduck.org>
Date: Fri, 18 Jan 2002 08:46:33 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: DervishD <raul@viadomus.com>
CC: linux-kernel@vger.kernel.org, yinlei_yu@hotmail.com
Subject: Re: Is there anyway to use 4M pages on x86 linux in user level?
In-Reply-To: <E16RYAn-0005jM-00@DervishD.viadomus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
> 
>     Hi Yinlei :)
> 
> >Since x86 architecutre has a 4M page feature
> 
>     I may certainly be wrong but... is not 4k OR 16M the page size on
> x86 arch? I didn't know about 4M page. Could you send me the GTD
> settings for that? (Just curiosity :)))

The large page size is 4MB, except in PAE mode where they are 2MB. 
Normal pages are always 4KB.  Noting in the GDT affects the page size.

-- 

						Brian Gerst
