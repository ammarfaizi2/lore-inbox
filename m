Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWGMN0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWGMN0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWGMN0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:26:36 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:41194 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751244AbWGMN0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:26:35 -0400
Date: Thu, 13 Jul 2006 15:26:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arjan van de Ven <arjan@infradead.org>, jakub@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linker error with latest tree on EM64T
Message-ID: <20060713132631.GA21657@mars.ravnborg.org>
References: <1152788160.4838.2.camel@localhost> <1152788387.3024.32.camel@laptopd505.fenrus.org> <1152791882.4838.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152791882.4838.6.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 01:58:02PM +0200, Marcel Holtmann wrote:
> > 
> > you are using ubuntu which has a compiler that adds -fstack-protector
> > implicitly to the compiler options, yet you don't have a kernel that
> > provides this infrastructure ;)
So go bug ubuntu...

> I couldn't find such a patch in Sam's repository
>From -linus:
# Force gcc to behave correct even for buggy distributions
CFLAGS          += $(call cc-option, -fno-stack-protector-all \
                                     -fno-stack-protector)

	Sam
