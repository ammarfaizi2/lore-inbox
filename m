Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264730AbTFQNrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbTFQNrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:47:46 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:27659 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264730AbTFQNrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:47:40 -0400
Subject: Re: gcc-3.2.2 miscompiles kernel 2.4.* O_DIRECT code ?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@redhat.com>
In-Reply-To: <20030617123745.GA5717@verdi.et.tudelft.nl>
References: <20030617123745.GA5717@verdi.et.tudelft.nl>
Content-Type: text/plain
Message-Id: <1055858491.588.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jun 2003 16:01:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-17 at 14:37, Rob van Nieuwkerk wrote:
> Hi,
> 
> I found out that O_DIRECT does not work correctly on 2.4 kernels
> compiled with the RH gcc-3.2.2-5 on RH9.  It is working fine with
> kernels compiled with the RH gcc-2.96-113 on RH 7.3.

Could you please try with gcc 3.3? I had similar problems when compiling
2.5 kernels with gcc 3.2. Compiling them with gcc 3.3 or 2.96 fixed the
problems.

