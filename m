Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271936AbRIMRu5>; Thu, 13 Sep 2001 13:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271935AbRIMRup>; Thu, 13 Sep 2001 13:50:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3395 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271942AbRIMRuf>; Thu, 13 Sep 2001 13:50:35 -0400
To: Jan Niehusmann <jan@gondor.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: Stomping on Athlon bug
In-Reply-To: <17613305632.20010913121304@port.imtp.ilyichevsk.odessa.ua>
	<3BA087CA.3BD1D557@redhat.com> <20010913141937.A1873@gondor.com>
	<20010913082149.B20967@devserv.devel.redhat.com>
	<20010913160225.A2316@gondor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Sep 2001 10:33:36 -0600
In-Reply-To: <20010913160225.A2316@gondor.com>
Message-ID: <m1r8tbt5i7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann <jan@gondor.com> writes:

> On Thu, Sep 13, 2001 at 08:21:49AM -0400, Arjan van de Ven wrote:
> > On Thu, Sep 13, 2001 at 02:19:38PM +0200, Jan Niehusmann wrote:
> > > But, as far as I understand, STPGNT will not be enabled unless ACPI
> > > power saving is in use, so setting the disconnect on STPGNT bit should
> > > not matter.
> > 
> > That is incorrect; it works perferctly well without ACPI.
> 
> Exactly what is incorrect?
> AFAICS, STPGNT is not triggered by hlt, so the linux idle function
> doesn't set STPGNT.

Hmm.  At least on the AMD76[12] you can trigger a processor disconnect
on hlt.  However the buggy BIOS had disconnects disabled so it doesn't/shouldn't
matter.

Eric
