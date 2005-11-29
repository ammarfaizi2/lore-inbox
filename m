Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVK2K0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVK2K0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 05:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVK2K0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 05:26:44 -0500
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:11745
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S1750946AbVK2K0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 05:26:44 -0500
Message-ID: <438C2C7C.1020004@winischhofer.net>
Date: Tue, 29 Nov 2005 11:25:00 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Adrian Bunk <bunk@stusta.de>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/misc/sisusbvga/sisusb.c: remove dead
 code
References: <20051120232239.GI16060@stusta.de> <20051123190237.GA28080@kroah.com> <20051123203150.GT3963@stusta.de> <20051128205220.GE17740@kroah.com>
In-Reply-To: <20051128205220.GE17740@kroah.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH wrote:
> On Wed, Nov 23, 2005 at 09:31:50PM +0100, Adrian Bunk wrote:
> 
>>On Wed, Nov 23, 2005 at 11:02:37AM -0800, Greg KH wrote:
>>
>>>On Mon, Nov 21, 2005 at 12:22:39AM +0100, Adrian Bunk wrote:
>>>
>>>>The Coverity checker found this obviously dead code.
>>>
>>>I think the checker is wrong, this does not look correct to me.
>>
>>Why?
>>
>>Due to the while(length), length can't be 0 at the switch.
> 
> 
> Doh, ok, nevermind.  Care to resend this?


Took me also a few seconds to realize that the tool is correct. Nice stuff.

Thomas

- --
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDjCx8zydIRAktyUcRAi8NAKCA96Bt9ibOIRGQWhSUy6qnd5QxYwCeLtHE
VvGqTMgnn476dnm/PYKBSM8=
=3eHZ
-----END PGP SIGNATURE-----
