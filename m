Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSHBQ5i>; Fri, 2 Aug 2002 12:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSHBQ5i>; Fri, 2 Aug 2002 12:57:38 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:42501 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S315921AbSHBQ5e>; Fri, 2 Aug 2002 12:57:34 -0400
Message-Id: <200208021700.g72H0bm02654@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Kasper Dupont <kasperd@daimi.au.dk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Race condition?
Date: Fri, 2 Aug 2002 16:48:19 +0200
X-Mailer: KMail [version 1.3.1]
References: <3D4A8D45.49226E2B@daimi.au.dk>
In-Reply-To: <3D4A8D45.49226E2B@daimi.au.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. August 2002 15:46 schrieb Kasper Dupont:
> Is there a race condition in this piece of code from do_fork in

It would seem so. Perhaps the BKL was taken previously.

	Regards
		Oliver
