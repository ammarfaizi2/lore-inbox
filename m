Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSFROcU>; Tue, 18 Jun 2002 10:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSFROcT>; Tue, 18 Jun 2002 10:32:19 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:24332 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S317429AbSFROcR> convert rfc822-to-8bit; Tue, 18 Jun 2002 10:32:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.4.19-pre10 link error - cpqarray related ?
Date: Tue, 18 Jun 2002 09:32:13 -0500
Message-ID: <A2C35BB97A9A384CA2816D24522A53BB01E88FF1@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.19-pre10 link error - cpqarray related ?
Thread-Index: AcIW01ehGfAI3xRhQNeY7Aju6lC21AAARTBQ
From: "White, Charles" <Charles.White@hp.com>
To: "Dave Jones" <davej@suse.de>
Cc: "Adrian Bunk" <bunk@fs.tum.de>, "Filip Sneppe" <filip.sneppe@chello.be>,
       <linux-kernel@vger.kernel.org>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>, "Arrays" <arrays@hp.com>
X-OriginalArrivalTime: 18 Jun 2002 14:32:14.0195 (UTC) FILETIME=[F066EC30:01C216D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.. 
I will look at that. 


-----Original Message-----
From: Dave Jones [mailto:davej@suse.de]
Sent: Tuesday, June 18, 2002 9:21 AM
To: White, Charles
Cc: Adrian Bunk; Filip Sneppe; linux-kernel@vger.kernel.org; Marcelo
Tosatti; Arrays
Subject: Re: 2.4.19-pre10 link error - cpqarray related ?


On Tue, Jun 18, 2002 at 09:11:23AM -0500, White, Charles wrote:
 > Interesting... It compiled for me fine.  Both statically and dynamic. 
 >  
 > What version of the compiler are you using?

__devexit/__devexit_p problems are a binutils issue.
Likely you have an older binutils which doesn't exhibit this problem.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
