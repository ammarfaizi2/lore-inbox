Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318661AbSHUSsq>; Wed, 21 Aug 2002 14:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318802AbSHUSsp>; Wed, 21 Aug 2002 14:48:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:13296 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318661AbSHUSsp>; Wed, 21 Aug 2002 14:48:45 -0400
Subject: Re: Overcommit_memory logic fails when swap is off
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: josip@icase.edu, linux-kernel@vger.kernel.org
In-Reply-To: <1029953073.1935.826.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 19:53:46 +0100
Message-Id: <1029956026.26411.116.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 19:04, Robert Love wrote:
> Alan, hch or someone asked if it would be possible to merge the 2.5
> behavior into 2.4-ac ... are you interested or do you not want to break
> compatibility?
> 
> Note for "mode 2" the behavior is identical.  For "mode 3" they would
> also need to set vm_memory_ratio to "0".

Obvious thing to do would be to add the 2.5 feature once its in a Linus
released 2.5 and clearly stable, and make mode 2 mode 3 overwrite that
value when you set them the old way.

I'm happy for that

