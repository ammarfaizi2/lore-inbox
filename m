Return-Path: <linux-kernel-owner+willy=40w.ods.org-S280979AbUKBDbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S280979AbUKBDbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S315529AbUKBDbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 22:31:37 -0500
Received: from smtp819.mail.sc5.yahoo.com ([66.163.170.5]:39279 "HELO
	smtp819.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S280979AbUKBDbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 22:31:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: No PS2 with ACPI [was Re: 2.6.10-rc1-mm2]
Date: Mon, 1 Nov 2004 22:31:24 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20041029014930.21ed5b9a.akpm@osdl.org> <200410301906.35335.dtor_core@ameritech.net> <1099346716l.7079l.0l@werewolf.able.es>
In-Reply-To: <1099346716l.7079l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411012231.24251.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 November 2004 05:05 pm, J.A. Magallon wrote:
> 
> On 2004.10.31, Dmitry Torokhov wrote:
> >  
> > > > BTW, what is that <NULL> ? 
> > > > I don't have the full logs, but 2.6.9-rc2-mm2 told 'Mouse',and
> > > > the next I have is -rc3-mm3 that says '<NULL>'.
> > > > 
> > 
> > Please try the patch below, I think it will cure the "NULL" problem - 
> > I messed up when rearranged protocols init routines.
> > 
> 
> It worked fine applied to 2.6.9-mm1:
> 
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: PS2++ Logitech Mouse on isa0060/serio1
> 
> Thanks!!
>

Thank you for trying it out.

> PD: will take a look at the other patch, but I have not an AMD64, my
> box is IA32...
> 

It looks like ACPI is a bit broken in -mm, sont bother with the 2nd patch.

-- 
Dmitry
