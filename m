Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262144AbREPXmc>; Wed, 16 May 2001 19:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262143AbREPXmW>; Wed, 16 May 2001 19:42:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37389 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262144AbREPXmM>; Wed, 16 May 2001 19:42:12 -0400
Subject: Re: LVM 1.0 release decision
To: Mauelshagen@sistina.com
Date: Thu, 17 May 2001 00:38:48 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010516150312.B13039@sistina.com> from "Heinz J. Mauelshagen" at May 16, 2001 03:03:12 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150AsS-0004du-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > code and your new release _before_ you do that.
> 
> The new code *can* automagically read and deal with 0.8 created VGDAs.
> What are you refering too in detail here?

Yes. This is good

The important thing is that the external interface and on disk format dont
break - the code can be broken/mended repeatedly the ABI is rather harder
to cure

> In the LV struct we can change it easily, because we just need the minor
> number which will nicely fit into the 32 bit we have.

Ok.  
