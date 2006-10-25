Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWJYSRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWJYSRW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 14:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWJYSRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 14:17:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44762 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030414AbWJYSRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 14:17:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <453FA220.3090001@wolfmountaingroup.com> 
References: <453FA220.3090001@wolfmountaingroup.com>  <453F9555.1050201@wolfmountaingroup.com> <16969.1161771256@redhat.com> <5c49b0ed0610250952i2fcc64b7t47fb7565cada14c6@mail.gmail.com> <25083.1161796876@redhat.com> 
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Nate Diller <nate.diller@gmail.com>, sds@tycho.nsa.gov, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 25 Oct 2006 19:15:58 +0100
Message-ID: <25891.1161800158@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey <jmerkey@wolfmountaingroup.com> wrote:

> Have it access them as 0.0 (root) when you change the fsuid, etc. and I think
> this would satisfy security concerns.

That's what I'm currently doing, but Christoph objected and said I'm not
allowed to change fsuid and fsgid.

That also doesn't cover the MAC issues.

> I agree that it sounds like someone needs to instrument MAC layers with this
> subsystem.

Yes.

David
