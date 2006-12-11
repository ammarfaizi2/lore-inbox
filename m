Return-Path: <linux-kernel-owner+w=401wt.eu-S1762921AbWLKN4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762921AbWLKN4K (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762924AbWLKN4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:56:10 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:46022 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762922AbWLKN4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:56:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=dloBbmNCuYKAEIT1i/q6X8h5oo+c0ggl0/cyNWCmWaKuSXF/qavuOX+jVpUT0IG1A/l+VreYfUInxLbr4lzQmHZC0TveAjCeS7GLghGRMuH/ijeVvDz22I+CtZYiRdNbyADTbo722xjchjW5VVMqn7DoNHxkpLlJPTcH+/rYZgg=
Message-ID: <457D636F.9020806@gmail.com>
Date: Mon, 11 Dec 2006 22:55:59 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: albertl@mail.com, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Oops in pata_pdc2027x
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>	 <457790F0.2070208@tw.ibm.com> <1165651032.1103.123.camel@localhost.localdomain>
In-Reply-To: <1165651032.1103.123.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Could that be related to the fix
> 
> [PATCH] libata: fix oops with sparsemem
> 
> That Arnd Bergmann just posted ? I'm copying it below in case you
> haven't seen it.

Seems to be the same problem to me.  I'll reply in the original thread.

Thanks.

-- 
tejun
