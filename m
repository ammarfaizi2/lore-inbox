Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVEEMB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVEEMB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVEEMB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:01:28 -0400
Received: from [195.23.16.24] ([195.23.16.24]:7830 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262059AbVEEMBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:01:19 -0400
Message-ID: <427A0B04.1030408@grupopie.com>
Date: Thu, 05 May 2005 13:01:08 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Rik van Riel <riel@redhat.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment policy
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>	<Pine.LNX.4.61.0505042109020.18390@chimarrao.boston.redhat.com> <m38y2uoukg.fsf@defiant.localdomain>
In-Reply-To: <m38y2uoukg.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Rik van Riel <riel@redhat.com> writes:
> 
> 
>>The problem is replying to an attachment.  The reason why having
>>the patch in the main mail body is good is that it gets quoted
>>by the email software and you can easily reply to individual
>>parts of the patch.
> 
> 
> If the attachment is "disposition=inline", does the problem still exist?

I've just checked this with Thunderbird (which is the mail client I use).

It not only sets the disposition=inline by default when attaching 
patches, it also places the patch inline when replying to it, allowing 
the user to write between the text of the patch as if it were part of 
the email text.

However if we Copy+Paste the patch into the mail it gets line wrapped / 
white space mangled.

So at least for Thunderbird users it would be better to use attached 
patches with "Content-Disposition: inline".

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
