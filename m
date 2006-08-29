Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWH1Xfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWH1Xfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 19:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWH1Xfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 19:35:38 -0400
Received: from main.gmane.org ([80.91.229.2]:41351 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964900AbWH1Xfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 19:35:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Date: Tue, 29 Aug 2006 02:35:26 +0200
Organization: Palacky University in Olomouc, experimental physics dep.
Message-ID: <44F38BCE.2080108@flower.upol.cz>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <1156803102.3465.34.camel@mulgrave.il.steeleye.com> <20060828230452.GA4393@powerlinux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: debian-kernel@lists.debian.org, Greg KH <greg@kroah.com>
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <20060828230452.GA4393@powerlinux.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Luther wrote:
> On Mon, Aug 28, 2006 at 05:11:42PM -0500, James Bottomley wrote:
 >
>>I've tested this with the aic94xx driver using the new MODULE_FIRMWARE()
>>tag.  Initramfs should be much easier because it already includes most
>>of the boot time loading; all it has to do is the piece identifying the
>>firmware for the selected modules.
...
> Notice that mkinitrd-tools is dead, and will probably be removed from etch.
> 
request_firmware() is dead also.
YMMV, but three years, and there are still big chunks of binary in kernel.
And please don't add new useless info _in_ it.

Nobody cares.
While this implementation exists, it wasn't well designed and hard to use.
As with in-kernel bootsplash and i18n, everything maybe done in userspace, only
with little help from the kernel:
<http://permalink.gmane.org/gmane.linux.kernel/435955>.

Thanks.

-- 
-o--=O`C  /. .\   (+)
  #oo'L O      o    |
<___=E M    ^--    |  (you're barking up the wrong tree)

