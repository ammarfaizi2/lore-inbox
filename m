Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUDKRml (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 13:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUDKRmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 13:42:40 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:27527 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262439AbUDKRmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 13:42:39 -0400
Subject: Re: Any plan for inclusion of linux-wlan-ng ?
From: Jon Oberheide <jon@focalhost.com>
To: =?ISO-8859-1?Q?Ga=EBl?= Le Mignot <kilobug@freesurf.fr>
Cc: linux-kernel@vger.kernel.org, info@linux-wlan.com
In-Reply-To: <plopm3lll26bsg.fsf@drizzt.kilobug.org>
References: <plopm3lll26bsg.fsf@drizzt.kilobug.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1081705342.22891.33.camel@latitude>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 11 Apr 2004 13:42:22 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-04-11 at 06:37, Gaël Le Mignot wrote:
> Hello,
> 
> I was just  wondering is there is any  plan of including linux-wlan-ng
> into  the 2.6  kernel. Does  someone know  about that  ? If  not, does
> someone know why ?

After a quick googling:

http://www.advogato.org/person/scandal/

According to this link, the wlan-ng drivers suffer a similar fate as
several other wireless drivers (e.g. HostAP) as they allow for
driver-based (as opposed to firmware-based) WEP encryption and
decryption.

Fortunately, the recent inclusion of the ARC4 module (by yours truly) in
the crypto API will allow these wireless drivers to use this
driver-based WEP and still be included in the kernel.  The Michael MIC
cipher was also recently included by HostAP to be used with TKIP.

I have CC'ed this to the linux-wlan guys in case they're not aware of
this development.

Regards,
Jon Oberheide
jon@focalhost.com


