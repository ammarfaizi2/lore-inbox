Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbSKUSeo>; Thu, 21 Nov 2002 13:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbSKUSeo>; Thu, 21 Nov 2002 13:34:44 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39628 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266961AbSKUSen>;
	Thu, 21 Nov 2002 13:34:43 -0500
Date: Thu, 21 Nov 2002 10:35:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Sam Ravnborg <sam@ravnborg.org>, john stultz <johnstul@us.ibm.com>
cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] subarch cleanup
Message-ID: <228760000.1037903743@flay>
In-Reply-To: <20021121183304.GA1144@mars.ravnborg.org>
References: <1037750429.4463.71.camel@w-jstultz2.beaverton.ibm.com> <20021121183304.GA1144@mars.ravnborg.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why do you need to move the .h files?

Because they're in a silly place now. They should be whereever all
the other include files are.

> CFLAGS += -Iarch/i386/$(MACHINE_H) -Iarch/i386/mach-generic
> That should achieve the same effect?

Header files go under include ....

M.

