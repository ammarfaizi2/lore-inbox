Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277740AbRJRPRE>; Thu, 18 Oct 2001 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277743AbRJRPQz>; Thu, 18 Oct 2001 11:16:55 -0400
Received: from t2.redhat.com ([199.183.24.243]:49908 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S277740AbRJRPQi>; Thu, 18 Oct 2001 11:16:38 -0400
Message-ID: <3BCEF26E.12D69882@redhat.com>
Date: Thu, 18 Oct 2001 16:17:02 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Murphy <murphy@panix.com>, linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
In-Reply-To: <3bceefa6.3cf6.0@panix.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Exported interfaces are "methods of operation" in the sense of US
> Copyright Law.  Copyright Law affords no protection to "methods of
> operation".  The GPL, which gains its strength from Copyright Law, also
> has no rights in this area.  If a GPLed module does not want other code
> using its interfaces, they should not be exported.

I think you're missing one thing: binary only modules are only allowed
because of an exception license grant Linus made for functions that are
marked EXPORT_SYMBOL(). EXPORT_SYMBOL_GPL() just says "not part of this 
exception grant"....
