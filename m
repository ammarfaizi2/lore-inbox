Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266809AbUBMHXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 02:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUBMHXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 02:23:06 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:43355 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266809AbUBMHXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 02:23:04 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Fri, 13 Feb 2004 02:23:00 -0500
User-Agent: KMail/1.6
Cc: Dominik Kubla <dominik@kubla.de>, Emmeran Seehuber <rototor@rototor.de>
References: <200402112344.23378.rototor@rototor.de> <20040213070333.GA1555@intern.kubla.de>
In-Reply-To: <20040213070333.GA1555@intern.kubla.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402130223.00339.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 02:03 am, Dominik Kubla wrote:
> On Wed, Feb 11, 2004 at 11:44:23PM +0000, Emmeran Seehuber wrote:
> > Hello everybody!
> > 
> > I'm trying to switch my laptop from kernel 2.4 to kernel 2.6.2. Everything 
> > seems to work correctly, only my PS/2 mouse doesn't.
> 
> Seconded. After update from 2.6.0 to 2.6.2 both the built-in touchpad and
> stick stopped working. XFree86 complained about "no such device" (or something
> similiar) when accessing /dev/psaux. /dev/input/mice is also configured but
> seems not to work.
> 
> Hardware is a Dell Inspiron 8000.
> 
> Regards,
>   Dominik

Do you have an active multiplexing controller and does passing i8042.nomux 
option help?

-- 
Dmitry
