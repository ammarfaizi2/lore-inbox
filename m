Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265774AbUGHEa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265774AbUGHEa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 00:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUGHEa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 00:30:26 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:51710 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265774AbUGHEaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 00:30:25 -0400
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: <linux-kernel@vger.kernel.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: Is there any equivalent function for itoa
References: <4EE0CBA31942E547B99B3D4BFAB34811038A53@mail.esn.co.in>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 08 Jul 2004 13:30:16 +0900
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811038A53@mail.esn.co.in> (Srinivas
 G.'s message of "Thu, 8 Jul 2004 09:53:51 +0530")
Message-ID: <buo1xjni0iv.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Srinivas G." <srinivasg@esntechnologies.co.in> writes:
> I have not found any itoa function in the linux library. 
>
> Is there any equivalent for that?

snprintf (buf, sizeof buf, "%d", int) ?

-miles
-- 
"Unless there are slaves to do the ugly, horrible, uninteresting work, culture
and contemplation become almost impossible. Human slavery is wrong, insecure,
and demoralizing.  On mechanical slavery, on the slavery of the machine, the
future of the world depends." -Oscar Wilde, "The Soul of Man Under Socialism"
