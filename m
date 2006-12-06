Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760545AbWLFMTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760545AbWLFMTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760546AbWLFMTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:19:44 -0500
Received: from mail.tbdnetworks.com ([204.13.84.99]:44224 "EHLO
	mail.tbdnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760545AbWLFMTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:19:43 -0500
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1165406299.3233.436.camel@laptopd505.fenrus.org>
References: <1165405350.5954.213.camel@titan.tbdnetworks.com>
	 <1165406299.3233.436.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: TBD Networks
Date: Wed, 06 Dec 2006 13:19:08 +0100
Message-Id: <1165407548.5954.224.camel@titan.tbdnetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 12:58 +0100, Arjan van de Ven wrote:
> On Wed, 2006-12-06 at 12:42 +0100, Norbert Kiesel wrote:
> > Hi,
> > 
> > I remember reading on LKML some time ago that using VMSPLIT_3G_OPT would
> > be optimal for a machine with exactly 1GB memory (like my current
> > desktop). Why is that option only prompted for after selecting EMBEDDED
> > (which I normally don't select for desktop machines
> 
> because it changes the userspace ABI and has some other caveats.... this
> is not something you should muck with lightly 
> 

Hmm, but it's also marked EXPERIMENTAL. Would that not be the
sufficient?  Assuming I don't use any external/binary drivers and a
self-compiled kernel w//o any additional patches: is there really any
downside?

</nk>
 

