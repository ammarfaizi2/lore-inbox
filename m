Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286372AbRLJUH1>; Mon, 10 Dec 2001 15:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286370AbRLJUHQ>; Mon, 10 Dec 2001 15:07:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12050 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286368AbRLJUHF>;
	Mon, 10 Dec 2001 15:07:05 -0500
Message-ID: <3C1515E6.9C6EC26@mandrakesoft.com>
Date: Mon, 10 Dec 2001 15:07:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.13-12mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul P Komkoff Jr <i@stingr.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTU vlan-related patch for tulip (2.4.x)
In-Reply-To: <20011210225759.B11450@stingr.net> <3C15146D.BA780B43@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To clarify, the patch takes PKT_BUF_SZ from (512*3) to (512*3)+4 which
moves away from the nice multiple of a power-of-2 number.
-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
