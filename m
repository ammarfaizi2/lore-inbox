Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422860AbWCXO2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422860AbWCXO2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWCXO2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:28:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8354 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932656AbWCXO2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:28:45 -0500
Subject: Re: Connector: Filesystem Events Connector v3
From: Arjan van de Ven <arjan@infradead.org>
To: yang.y.yi@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Matt Helsley <matthltc@us.ibm.com>
In-Reply-To: <4c4443230603240624g132b8d37t1a271a8303b810bf@mail.gmail.com>
References: <4423673C.7000008@gmail.com>
	 <1143183541.2882.7.camel@laptopd505.fenrus.org>
	 <4c4443230603240624g132b8d37t1a271a8303b810bf@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 15:28:43 +0100
Message-Id: <1143210523.2882.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 22:24 +0800, yang.y.yi@gmail.com wrote:
> On 3/24/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > > It is also never redundant functionality of audit subsystem, if enable
> > > audit option, audit subsystem will audit all the syscalls, so it adds
> > > big overhead for the whole system,
> >
> > this is not true
> Hmm, Why?

audit only audits those syscalls (or rather, operations) you enable it
to audit basically.


