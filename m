Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293462AbSCFKuy>; Wed, 6 Mar 2002 05:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293463AbSCFKun>; Wed, 6 Mar 2002 05:50:43 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:27637 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293462AbSCFKue>; Wed, 6 Mar 2002 05:50:34 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200203051812.NAA03363@ccure.karaya.com> 
In-Reply-To: <200203051812.NAA03363@ccure.karaya.com> 
To: Jeff Dike <jdike@karaya.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 10:49:52 +0000
Message-ID: <505.1015411792@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jdike@karaya.com said:
>  And I don't see anything wrong with starting a bunch of UMLs with a
> total maximum memory exceeding the available tmpfs as long as they
> don't all need all that memory at once.  And, if they do, the patch I
> just posted will let them deal fairly sanely with the situation.

Going off at a slight tangent...

You say 'at once'. Does UML somehow give pages back to the host when they're 
freed, so the pages that are no longer used by UML can be discarded by the 
host instead of getting swapped?

--
dwmw2


