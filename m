Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279390AbRJWLrc>; Tue, 23 Oct 2001 07:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279389AbRJWLrW>; Tue, 23 Oct 2001 07:47:22 -0400
Received: from hermes.domdv.de ([193.102.202.1]:48902 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S279390AbRJWLrK>;
	Tue, 23 Oct 2001 07:47:10 -0400
Message-ID: <XFMail.20011023134632.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BD5572D.6969280B@mandrakesoft.com>
Date: Tue, 23 Oct 2001 13:46:32 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH] ext2 module build failure (2.4.13pre6)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# nm ./lib/modules/2.4.13-pre6/kernel/fs/ext2/ext2.o | \
> grep generic_direct_IO
         U generic_direct_IO
#

Now what's that? some ghost?

On 23-Oct-2001 Jeff Garzik wrote:
> Andreas Steinmetz wrote:
>> 
>> ext2 build as a module fails to missing export of generic_direct_IO which
>> the
>> attached patch fixes.
>> 
>> <grumble>
>> posted this at 2.4.13pre2 time, now we're up to pre6 and nobody cares...
>> </grumble>
> 
> Interesting considering this function does not exist at all in
> 2.4.13-pre6...
> 
>       Jeff
> 
> 
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> 
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
