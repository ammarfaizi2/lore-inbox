Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130899AbQKTFGL>; Mon, 20 Nov 2000 00:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130537AbQKTFGB>; Mon, 20 Nov 2000 00:06:01 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:29735 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130471AbQKTFFv>; Mon, 20 Nov 2000 00:05:51 -0500
Message-ID: <3A18AA1F.FAC00978@linux.com>
Date: Sun, 19 Nov 2000 20:35:43 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: run level 1, login takes too long, 2.4.X vs. 2.2.X
In-Reply-To: <3A18573B.E65CA88A@megsinet.net>
Content-Type: multipart/mixed;
 boundary="------------B7081790DBE90D7DE0CCF525"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B7081790DBE90D7DE0CCF525
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

rpc.portmap isn't running, your login configuration/nss requires yp or something provided ans an RPC.

-d

"M.H.VanLeeuwen" wrote:

> I had occasion to "telinit 1" today and found that it took a long time
> to login after root passwd was entered.  this doesn't happen with 2.2.X
> kernels.
>
> Is this to be expected with the 2.4 series kernels? or a bug?
>
> Martin

--------------B7081790DBE90D7DE0CCF525
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------B7081790DBE90D7DE0CCF525--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
