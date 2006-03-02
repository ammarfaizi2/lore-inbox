Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752063AbWCBTwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbWCBTwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbWCBTwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:52:46 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:58793 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1752063AbWCBTwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:52:45 -0500
Message-ID: <44074CFD.7050708@vilain.net>
Date: Fri, 03 Mar 2006 08:52:29 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 3/5] NFS: Abstract out namespace initialisation
 [try #2]]
References: <20060302084448.GA21902@infradead.org>  <440613FF.4040807@vilain.net> <3254.1141299348@warthog.cambridge.redhat.com>
In-Reply-To: <3254.1141299348@warthog.cambridge.redhat.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
>>>The attached patch abstracts out the namespace initialisation so that 
>>>temporary namespaces can be set up elsewhere.
>>Definitily shouldb't be inline.  And until you have a second caller
>>it's utterly pointless.  So NACK for now.
> I presume from that you didn't notice that the second caller was in patch 5/5?

AIUI, each patch must stand on its own in every regard.  I guess you 
need to make it inline in the later patch - or not at all given the 
marginal speed difference vs. core size increase.

Sam.
