Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281420AbRKPNiP>; Fri, 16 Nov 2001 08:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281419AbRKPNiF>; Fri, 16 Nov 2001 08:38:05 -0500
Received: from mail022.mail.bellsouth.net ([205.152.58.62]:36903 "EHLO
	imf22bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281418AbRKPNhy>; Fri, 16 Nov 2001 08:37:54 -0500
Message-ID: <3BF51696.1DC5D3CC@mandrakesoft.com>
Date: Fri, 16 Nov 2001 08:37:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: synchronous mounts
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au> <20011115214525.C14221@redhat.com> <3BF45B9F.DEE1076B@mandrakesoft.com> <20011116122855.C2389@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May I suggest another way of thinking about this issue.  ext3 allows one
to journal everything, or just metadata.  Why -avoid- this distrinction
when it comes to the 'sync' mount option (and 'dirsync' or 'metasync')?
-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

