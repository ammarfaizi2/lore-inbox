Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbTEHWez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbTEHWey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:34:54 -0400
Received: from almesberger.net ([63.105.73.239]:60677 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262206AbTEHWe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:34:28 -0400
Date: Thu, 8 May 2003 19:47:00 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, romieu@fr.zoreil.com, chas@locutus.cmf.nrl.navy.mil,
       linux-kernel@vger.kernel.org
Subject: Re: [ATM] [PATCH] unbalanced exit path in Forerunner HE he_init_one()
Message-ID: <20030508194700.C13069@almesberger.net>
References: <200305071813.h47IDpc9010906@hera.kernel.org> <20030508010146.A20715@electric-eye.fr.zoreil.com> <20030508060640.A24325@infradead.org> <20030508.035442.85387749.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508.035442.85387749.davem@redhat.com>; from davem@redhat.com on Thu, May 08, 2003 at 03:54:42AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> This one goes all the way back to when Werner still maintained
> the ATM layer, and frankly back then we didn't give a crap
> about these issues as much as we do now.

Actually, the HE driver is a more recent addition. But I have to
admit that my own drivers have more #ifdefs than really necessary,
too. Also, I saw my role more as that of an integrator than a
reviewer, so I let people do whatever they liked in their drivers.

Ah, the good old times, when everything was better ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
