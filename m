Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLGNf0>; Thu, 7 Dec 2000 08:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQLGNfP>; Thu, 7 Dec 2000 08:35:15 -0500
Received: from [62.172.234.2] ([62.172.234.2]:52657 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129352AbQLGNfD>;
	Thu, 7 Dec 2000 08:35:03 -0500
Date: Thu, 7 Dec 2000 13:06:33 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Broken NR_RESERVED_FILES
In-Reply-To: <Pine.LNX.4.30.0012071354070.5455-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0012071304481.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another comment on your patch. You removed the goto used_one (probably a
good idea, I hated it as well and preferred to put it into the if()) but
you forgot to remove the label itself.

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
