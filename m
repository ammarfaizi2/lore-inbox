Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272315AbRIEUoo>; Wed, 5 Sep 2001 16:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272316AbRIEUof>; Wed, 5 Sep 2001 16:44:35 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:19374 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272315AbRIEUoW>;
	Wed, 5 Sep 2001 16:44:22 -0400
Date: Wed, 05 Sep 2001 21:44:38 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Buddy allocator - help! I thought I understood this
Message-ID: <1296618548.999726278@[169.254.198.40]>
In-Reply-To: <525190103.999719280@[10.132.112.53]>
In-Reply-To: <525190103.999719280@[10.132.112.53]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for the responses. FWIW:

> (NB, if this is a code bug rather than local brain
>  bug, this explains a lot)

It's was a transient local brain bug. The bit
is shared between two pages of the same order.

>    101          index = page_idx >> (1 + order);
                   I missed this today ^^^

And hence my previous patch did have a bug,
for arcane reasons; I'll resubmit it if
it works.

--
Alex Bligh
