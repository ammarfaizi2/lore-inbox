Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310566AbSCGWov>; Thu, 7 Mar 2002 17:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310565AbSCGWop>; Thu, 7 Mar 2002 17:44:45 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:37870 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S310571AbSCGWoL>; Thu, 7 Mar 2002 17:44:11 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E16j3Sj-0003Jb-00@the-village.bc.nu> 
In-Reply-To: <E16j3Sj-0003Jb-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: phillips@bonn-fries.net (Daniel Phillips), yodaiken@fsmlabs.com,
        jdike@karaya.com (Jeff Dike), bcrl@redhat.com (Benjamin LaHaise),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Mar 2002 22:43:09 +0000
Message-ID: <1595.1015540989@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Not having a fallback is unacceptable. Thats the real problem. You
> can't go around pandering to sloppy coders who can't work a memory
> allocator 

OTOH there is perhaps some justification for distinguishing between 'If you 
fail this I'll tell the user -ENOMEM and continue happily on my way' 
allocations and 'If you fail this I lose track of hardware state and all is 
fucked till we reboot' ones.

--
dwmw2


