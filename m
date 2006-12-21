Return-Path: <linux-kernel-owner+w=401wt.eu-S1422801AbWLUHcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbWLUHcl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422802AbWLUHcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:32:41 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:24503 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422801AbWLUHck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:32:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oojC75iRsq02WKFomLWFyDdJ4nht0vl5DJJu2CJVpeUrVnN5886HyU8dGfu03Lwol7ULSbJiP67T2lwyC68SRsYSkK9R40TsAkW8twKAIZOD+y9ivFQX0scxcjQwqUyP0Bof3BHvZxCi/vlmq/OdWpP9QcK1Qgtx6Uc1alHKWp8=
Message-ID: <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
Date: Thu, 21 Dec 2006 00:32:39 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Martin Michlmayr" <tbm@cyrius.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrei Popa" <andrei.popa@i-neo.ro>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       "Arnd Bergmann" <arnd.bergmann@de.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	 <1166622979.10372.224.camel@twins>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Linus Torvalds <torvalds@osdl.org> wrote:

> Ok, I'll just put my money where my mouth is, and suggest a patch like
> THIS instead.

> Martin, Andrei, does this make any difference for your corruption cases?

Unfortunately, I cannot get the latest git version of the kernel to
boot on the ARM machine on which Martin and I are experiencing the apt
segfault. After the kernel is finished uncompressing it prints "done,
booting the kernel." as expected, but nothing more happens. I have
tried both with and without the patch. Hopefully either Andrei or
Martin will have better luck at testing this patch than I have had.

Gordon

-- 
Gordon Farquharson
