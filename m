Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVCPR27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVCPR27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVCPR27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:28:59 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:21637 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262703AbVCPR2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:28:55 -0500
Date: Wed, 16 Mar 2005 18:29:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net,
       dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3 mouse oddity
Message-ID: <20050316172947.GC1608@ucw.cz>
References: <20050312034222.12a264c4.akpm@osdl.org> <4236D428.4080403@aitel.hist.no> <d120d50005031506252c64b5d2@mail.gmail.com> <20050315110146.4b0c5431.akpm@osdl.org> <20050315201038.GA5484@ucw.cz> <42380094.2050704@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42380094.2050704@aitel.hist.no>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 10:47:00AM +0100, Helge Hafting wrote:

> >Mouse device numbers are defined to be unstable because of hotplug.
> >
> >Most users use /dev/input/mice, where this won't have impact.
> >
> >The officially correct solution is to use udev to get stable device
> >names.
> >
> >The change is easily reverted - just change the 'atkbd.scroll' default
> >value.

> Please don't remove it - it is nice to have support for the hardware.
> Apps using this is also necessary - and they are possible now.
> If you want to go the route of least surprise you may want to
> make sure the "new" mice get higher numbers instead of
> pushing "older" mice around.
 
The numbers are based on probe order, first come, first serve. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
