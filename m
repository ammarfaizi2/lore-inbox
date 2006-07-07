Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWGGH27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWGGH27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWGGH27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:28:59 -0400
Received: from mail.artecdesign.ee ([62.65.32.9]:39124 "EHLO
	postikukk.artecdesign.ee") by vger.kernel.org with ESMTP
	id S1750780AbWGGH27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:28:59 -0400
Message-ID: <44AE0DD5.4080907@artecdesign.ee>
Date: Fri, 07 Jul 2006 10:31:33 +0300
From: Indrek Kruusa <indrek.kruusa@artecdesign.ee>
Organization: Artec Design =?ISO-8859-1?Q?O=DC?=
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Limit VIA and SIS AGP choices to x86
References: <20060705175725.GL1605@parisc-linux.org>	 <20060705192147.GF1877@redhat.com> <1152127676.3201.62.camel@laptopd505.fenrus.org> <44AC318A.5050303@zytor.com>
In-Reply-To: <44AC318A.5050303@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ADG-Spam-Score: -2.6 (--)
X-ADG-Spam-ScoreInt: -25
X-ADG-Spam-Report: Content analysis details:   (-2.6 points, 5.5 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
X-ADG-ExiScan-Signature: 332d580f8b3c815424e27143dcf02376
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Arjan van de Ven wrote:
>> On Wed, 2006-07-05 at 15:21 -0400, Dave Jones wrote:
>>> On Wed, Jul 05, 2006 at 11:57:25AM -0600, Matthew Wilcox wrote:
>>>  >  > As far as I am aware, Alpha, PPC and IA64 don't have VIA or 
>>> SIS AGP
>>>  > chipsets available.
>>>
>>> VIA has turned up on PPC (some Apple notebooks).
>>
>> only the southbridge... agp is a northbridge thing...
>>
>
> Not necessarily.  Some HyperTransport southbridges have AGP on them, 
> for example.

Yes, and this is evil because historically 90% people think about 
"xxxxxbridge" as "right bunch" of implemented electrical interfaces and 
not by MSR's or whatever else :)


Indrek

