Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269049AbRHGR10>; Tue, 7 Aug 2001 13:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269212AbRHGR1Q>; Tue, 7 Aug 2001 13:27:16 -0400
Received: from t2.redhat.com ([199.183.24.243]:5360 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S269049AbRHGR1A>; Tue, 7 Aug 2001 13:27:00 -0400
Message-ID: <3B7024EE.D58E6BF@redhat.com>
Date: Tue, 07 Aug 2001 18:27:10 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-0.9smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108070517.f775HEw30547@vindaloo.ras.ucalgary.ca>
		<Pine.SOL.3.96.1010807111835.6737A-100000@draco.cus.cam.ac.uk> <200108071709.f77H9GD05198@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
 
> Finally, a spinlock is less code (0) and faster on UP.

Ehm not if you require protection against IRQ events......
