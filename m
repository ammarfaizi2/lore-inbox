Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVGGIPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVGGIPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVGGIPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:15:40 -0400
Received: from web25804.mail.ukl.yahoo.com ([217.12.10.189]:28260 "HELO
	web25804.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261216AbVGGIPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:15:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2J9+rdfKUoZLeDuxuIcEIuCtTNckror+Q3PKPC+0HIoFtJbTQJPdSjJ4KDOXJSZxLfwPMVbh3JMllJYSOS116VKboobu2qL9ujmRfuUNdS83sYLpf+Ehoga/Ve3a2pKP9ALan4AOwuN2h73gxGlkdAWHBhM4znOeN/Ukaa2sg08=  ;
Message-ID: <20050707081537.84373.qmail@web25804.mail.ukl.yahoo.com>
Date: Thu, 7 Jul 2005 10:15:37 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Willy Tarreau <willy@w.ods.org>, Pekka Enberg <penberg@gmail.com>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       linux-kernel@vger.kernel.org,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:

> Hi Willy,
> Willy Tarreau writes:
>
>> I dont agree with you here : enums are good to simply specify an ordering.
>> But they must not be used to specify static mapping. Eg: if REG4 *must* be
>> equal to BASE+4, you should not use enums, otherwise it will render the
>> code unreadable. I personnaly don't want to count the position of REG7 in
>> the enum to discover that it's at BASE+7.
>
>
> Sorry, what do you have to count with the following?
> enum {
>       TLCLK_REG0 = TLCLK_BASE,
>       TLCLK_REG1 = TLCLK_BASE+1,
>       TLCLK_REG2 = TLCLK_BASE+2,
> };
> Please note that enums are a general way of specifying _constants_ with the
type int, not necessarily named enumerations. 

BTW, a lot of drivers use define for register mapping in kernel. Since enum
is not a new C feature, I'm wondering why kernel have prefered using define
in the past...

thanks,

      Francis





	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
