Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVEEVeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVEEVeu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 17:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEEVeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 17:34:50 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:54453 "EHLO
	mailwasher.lanl.gov") by vger.kernel.org with ESMTP id S261918AbVEEVer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 17:34:47 -0400
Message-ID: <427A9169.6050300@mesatop.com>
Date: Thu, 05 May 2005 15:34:33 -0600
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Krzysztof Halasa <khc@pm.waw.pl>, Rik van Riel <riel@redhat.com>,
       Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment policy
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>	<Pine.LNX.4.61.0505042109020.18390@chimarrao.boston.redhat.com> <m38y2uoukg.fsf@defiant.localdomain> <427A0B04.1030408@grupopie.com>
In-Reply-To: <427A0B04.1030408@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> Krzysztof Halasa wrote:
> 
>> Rik van Riel <riel@redhat.com> writes:
>>
>>
>>> The problem is replying to an attachment.  The reason why having
>>> the patch in the main mail body is good is that it gets quoted
>>> by the email software and you can easily reply to individual
>>> parts of the patch.
>>
>>
>>
>> If the attachment is "disposition=inline", does the problem still exist?
> 
> 
> I've just checked this with Thunderbird (which is the mail client I use).
> 
> It not only sets the disposition=inline by default when attaching 
> patches, it also places the patch inline when replying to it, allowing 
> the user to write between the text of the patch as if it were part of 
> the email text.
> 
> However if we Copy+Paste the patch into the mail it gets line wrapped / 
> white space mangled.

That depends on where you are Copy+Pasting from.  Granted, Copy+Paste from
a variety of sources is a nightmare.  But, Copy+Paste from Tbird to Tbird
seems to actually work.

> 
> So at least for Thunderbird users it would be better to use attached 
> patches with "Content-Disposition: inline".
> 

Here is a trick you can play with Thunderbird to get inlined patches:

1) Mail the patch to yourself as an attachment.
2) Read the mail you just got, copy and paste the patch to your new message.

This method preserves the tabs/whitespace. Of course, you have to set the
wordwrap settings appropriately. It works for me.

Steven
