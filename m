Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbUKHWSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUKHWSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUKHWSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:18:51 -0500
Received: from smtp-out.hotpop.com ([38.113.3.51]:33426 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261278AbUKHWSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:18:35 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, adaplas@pol.net
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Tue, 9 Nov 2004 06:18:10 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Guido Guenther <agx@sigxcpu.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411081633.00645.adaplas@hotpop.com> <1099950617.3946.163.camel@gaston>
In-Reply-To: <1099950617.3946.163.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411090618.10418.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 November 2004 05:50, Benjamin Herrenschmidt wrote:
> On Mon, 2004-11-08 at 16:33 +0800, Antonino A. Daplas wrote:
> > Hmm, I'll ask Guido Guenther if he can test the changes. I think a
> > different set of access macros for PPC might be a more preferrable
> > solution.
>
> Well, I'd rather leave the registers Little Endian, but then, it will
> clash with X which does put them into Big Endian mode, so that would
> have to be restored all the time.
>

I also asked Guido if he can test the removal of the code that puts the
hardware in big endian, although I told him that I prefer a new set of
access macros.  But I'll leave this decision to you people. 

Tony



