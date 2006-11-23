Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757223AbWKWA2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757223AbWKWA2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 19:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757225AbWKWA2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 19:28:30 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:50984 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1757223AbWKWA23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 19:28:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MgGkQV2TQ8Jr+V/gmGsPRo/9iwhVJNBd0rn0ido90Jv0/mWT3/ge/MQCTZoRzeOBl7OBQOFF34iTBsD21r004wzeVYEC7TMSB3BXQsNVoZiegOob/R3nJK2DdZ1evFqwYuxk9uS1pFMgPVO+dZPqTnhvkzxQvteVPPKD8KyQHgM=
Message-ID: <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com>
Date: Wed, 22 Nov 2006 17:28:28 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: ieee1394: host adapter disappears on 1394 bus reset
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <4564C4C7.5060403@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>
	 <4564C4C7.5060403@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> It would be nice if you create an entry at bugzilla.kernel.org.

Okay, bug # is 7569.

> One thing you could try next is to add a debug logging macro which
> prints the contents of OHCI1394_IntEventClear, OHCI1394_IntEventSet, and
> OHCI1394_IntMaskSet, right after ohci1394's call to
> hpsb_selfid_complete. (I'm merely poking in the dark here.)

We're just entering a holiday weekend here (Thursday is Thanksgiving),
but I will try when I return on Monday.

Thanks.

-- 
Robert Crocombe
rcrocomb@gmail.com
