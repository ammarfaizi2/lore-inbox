Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWGMNaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWGMNaW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWGMNaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:30:21 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:38602 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1030195AbWGMNaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:30:21 -0400
Subject: Re: Linker error with latest tree on EM64T
From: Marcel Holtmann <marcel@holtmann.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Arjan van de Ven <arjan@infradead.org>, jakub@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060713132631.GA21657@mars.ravnborg.org>
References: <1152788160.4838.2.camel@localhost>
	 <1152788387.3024.32.camel@laptopd505.fenrus.org>
	 <1152791882.4838.6.camel@localhost>
	 <20060713132631.GA21657@mars.ravnborg.org>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 15:30:21 +0200
Message-Id: <1152797421.4838.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

> > > you are using ubuntu which has a compiler that adds -fstack-protector
> > > implicitly to the compiler options, yet you don't have a kernel that
> > > provides this infrastructure ;)
> So go bug ubuntu...

yeah, yeah.

> > I couldn't find such a patch in Sam's repository
> From -linus:
> # Force gcc to behave correct even for buggy distributions
> CFLAGS          += $(call cc-option, -fno-stack-protector-all \
>                                      -fno-stack-protector)

I used the latest tree from Linus and I see this in the Makefile, but it
is not working.

Regards

Marcel


