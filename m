Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUJWEQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUJWEQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUJWEPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:15:09 -0400
Received: from imap.gmx.net ([213.165.64.20]:59806 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264246AbUJVRd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:33:28 -0400
X-Authenticated: #14776911
From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
Reply-To: stefandoesinger@gmx.at
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 22 Oct 2004 19:31:37 +0200
User-Agent: KMail/1.7
Cc: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
References: <88056F38E9E48644A0F562A38C64FB6003287C77@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6003287C77@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410221931.37557.stefandoesinger@gmx.at>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually I sent the kernel patch to call some userlevel vgapost utility
> on this same thread around a week back. I am sending it here again.
>
> I don't think sending a big userlevel code tar file is appropriate on
> lkml.
> I will send that in a separate mail to Matthew and Stefan. If anyone
> else
> wants to play with it, just let me know.
>
> It works for me on various systems with Radeon card. It didn't help on
> systems with Intel Graphics card.
Works for me too. You can add "Acer Travelmate 800" to the it_works_on 
list ;-)

> Stefan: Yes. Usermodehelper won't work during the driver resume. But, it
>
> works later after the kernel threads are woken up. With attached patch
> and
> with user level vgapost I can get video back, both on X and VGA console.
> It doesn't help with framebuffer, as the framebuffer reinitialization
> happens during the driver resume, which is earlier than this vgapost
> call.
I expected this, but I hoped that it works somehow with radeonfb.

Stefan
