Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271705AbRIMOCu>; Thu, 13 Sep 2001 10:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271706AbRIMOCk>; Thu, 13 Sep 2001 10:02:40 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:1299 "EHLO
	anduin.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S271705AbRIMOC2>; Thu, 13 Sep 2001 10:02:28 -0400
Date: Thu, 13 Sep 2001 16:02:25 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: Stomping on Athlon bug
Message-ID: <20010913160225.A2316@gondor.com>
In-Reply-To: <17613305632.20010913121304@port.imtp.ilyichevsk.odessa.ua> <3BA087CA.3BD1D557@redhat.com> <20010913141937.A1873@gondor.com> <20010913082149.B20967@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010913082149.B20967@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 08:21:49AM -0400, Arjan van de Ven wrote:
> On Thu, Sep 13, 2001 at 02:19:38PM +0200, Jan Niehusmann wrote:
> > But, as far as I understand, STPGNT will not be enabled unless ACPI
> > power saving is in use, so setting the disconnect on STPGNT bit should
> > not matter.
> 
> That is incorrect; it works perferctly well without ACPI.

Exactly what is incorrect?
AFAICS, STPGNT is not triggered by hlt, so the linux idle function
doesn't set STPGNT.

Jan

