Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTJMPMy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTJMPMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:12:54 -0400
Received: from mx3.Informatik.Uni-Tuebingen.De ([134.2.12.26]:35230 "EHLO
	mx3.informatik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S261838AbTJMPMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:12:52 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: alpha@steudten.com
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: raid1.c and gcc problem/oops (was: [INFO] gcc versions used to compile a kernel
References: <3F8ACFA0.10239.10815846@localhost>
	<3F8AB9A9.9010502@steudten.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 13 Oct 2003 17:12:45 +0200
In-Reply-To: <3F8AB9A9.9010502@steudten.com>
Message-ID: <87llrp5fyq.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Steudten <alpha@steudten.com> writes:

> On alpha, as i described in this list, i got an oops in raid1.c for
> kernel 2.4.17..21, 2.6.0-test7 with gcc-2.95.3, gcc-3.3 (3.4 is in
> work by me).

It seems like the fix was accidentally not committed for the 3.3
branch (see http://gcc.gnu.org/bugzilla/show_bug.cgi?id=11087). I hope
we can still include it for the upcoming 3.3.2 release.

-- 
	Falk
