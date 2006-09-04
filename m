Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWIDRIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWIDRIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWIDRIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:08:49 -0400
Received: from main.gmane.org ([80.91.229.2]:58342 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964940AbWIDRIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:08:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] [USB] hid-core.c: Fix apparent typo in   GTCO blacklist
 entries
Date: Mon, 04 Sep 2006 20:08:26 +0200
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <44FC6B9A.1000402@flower.upol.cz>
References: <87pseb61cj.fsf@digitalvampire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <87pseb61cj.fsf@digitalvampire.org>
X-Image-Url: http://flower.upol.cz/~olecom/upol-cz.png
X-Face: =sibd$\hCvyTK_%u<|5M05t1lOc1Ld1'SSQ`+=v3P7:)0g%v{U`~4(q4"X(az&asiUNG.C3)XS1E`)4O'hK0{r}P9fxtLGVWvQQJekut9!Q"K8H2l>/Tfd.~R@PoY{TfjXUht[HdA+.Ncy?W;*K$5v(|n-=C6mne&mN}1(n
Cc: linux-usb-users@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> Commit 6f8d9e26e7deecb1296c221aa979542bc5d63f20 added blacklist
> entries for GTCO products, but it included an apparent cut-and-paste
> typo (the device ID entry for GTCO_404 is duplicated with two
> different values, and used twice in the blacklist).  This leads to the
> warning:
> 
>     drivers/usb/input/hid-core.c:1447:1: warning: "USB_DEVICE_ID_GTCO_404" redefined
> 
> Fix this by correcting the second device ID name to GTCO_405, and
> using it in the blacklist.
> 
> Signed-off-by: Roland Dreier <roland@digitalvampire.org>
> 
It was patched today already.
<http://permalink.gmane.org/gmane.linux.kernel/443314>

-- 
-o--=O`C
  #oo'L O $ dd </all:xml>/dev/null
<___=E M

