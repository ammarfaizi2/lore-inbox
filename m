Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270720AbRHPDOc>; Wed, 15 Aug 2001 23:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270719AbRHPDOW>; Wed, 15 Aug 2001 23:14:22 -0400
Received: from zok.sgi.com ([204.94.215.101]:26573 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S270716AbRHPDOO>;
	Wed, 15 Aug 2001 23:14:14 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: daddr_t is inconsistent and barely used 
In-Reply-To: Your message of "Thu, 16 Aug 2001 04:57:34 +0200."
             <200108160257.f7G2vYA18080@ns.caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Aug 2001 13:14:20 +1000
Message-ID: <10589.997931660@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001 04:57:34 +0200, 
Christoph Hellwig <hch@ns.caldera.de> wrote:
>In article <9980.997929632@kao2.melbourne.sgi.com> you wrote:
>> daddr_t is barely used in the kernel.  2.4.8.
>>
>> The use of daddr_t in freevxfs may give different in core and disk
>> layouts on different machines.  Is that intended?.
>
>No, it may not.  Please double check.

That is why I said "may".  It seemed puzzling that freevxfs used
vx_daddr_t for almost everything but daddr_t for a couple of fields.
An inconsistency with no obvious reason.

