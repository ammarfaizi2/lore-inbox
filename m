Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbUKVPlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbUKVPlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUKVPiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 10:38:12 -0500
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:56831 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S261451AbUKVPPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:15:11 -0500
From: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6: drivers/video/aty/xlinit.c unused
Date: Mon, 22 Nov 2004 16:15:00 +0100
User-Agent: KMail/1.7.1
References: <20041121020636.GH2829@stusta.de> <200411220821.22620.adaplas@hotpop.com>
In-Reply-To: <200411220821.22620.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411221615.00477.marc.dietrich@ap.physik.uni-giessen.de>
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Am Montag, 22. November 2004 01:21 schrieb Antonino A. Daplas:
> On Sunday 21 November 2004 10:06, Adrian Bunk wrote:
> > It seems drivers/video/aty/xlinit.c should be used with
> > CONFIG_FB_ATY_XL_INIT, but currently, it's under no circumstances
> > compiled...
>
> It's supposed to boot XL cards without using the BIOS.
>
> If nobody complains, I'll remove it.

why not making it work? I have some of these cards here that I never got 
working in my Mac or my Powerstack (both PPC).
Or should it be removed to make room for a "general early boot video 
initialisation infrastructure", which was discussed here some weeks ago?

Greetings

Marc

