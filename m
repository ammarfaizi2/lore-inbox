Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265036AbUKAX0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbUKAX0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S381702AbUKAXZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:25:31 -0500
Received: from smtp06.auna.com ([62.81.186.16]:33459 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S324548AbUKAWFU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:05:20 -0500
Date: Mon, 01 Nov 2004 22:05:16 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: No PS2 with ACPI [was Re: 2.6.10-rc1-mm2]
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
	<1099149503l.23066l.0l@werewolf.able.es>
	<20041030143132.5f20d048.akpm@osdl.org>
	<200410301906.35335.dtor_core@ameritech.net>
In-Reply-To: <200410301906.35335.dtor_core@ameritech.net> (from
	dtor_core@ameritech.net on Sun Oct 31 02:06:32 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1099346716l.7079l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.31, Dmitry Torokhov wrote:
>  
> > > BTW, what is that <NULL> ? 
> > > I don't have the full logs, but 2.6.9-rc2-mm2 told 'Mouse',and
> > > the next I have is -rc3-mm3 that says '<NULL>'.
> > > 
> 
> Please try the patch below, I think it will cure the "NULL" problem - 
> I messed up when rearranged protocols init routines.
> 

It worked fine applied to 2.6.9-mm1:

mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS2++ Logitech Mouse on isa0060/serio1

Thanks!!

PD: will take a look at the other patch, but I have not an AMD64, my
box is IA32...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #7


