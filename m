Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVCXWGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVCXWGx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVCXWGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:06:53 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:16164 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261156AbVCXWGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:06:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=J3GIFVHNYc/Zz3/vqw+OKl2q2Prjq4Antg5KYj86qcSd7tDQUFECZfPbTu9Yt7R6iMa3QWAUKnF/Pcij6Y/L1LQ8FyBQfge/DTqK0liFHiPbLcDfd8W3425kJM7Fd0ndU4R54tJSPnz5eto7EwgrM4dT1Cl4ssS/CVyO2UGFX0Y=
Message-ID: <aec7e5c3050324140667759f0a@mail.gmail.com>
Date: Thu, 24 Mar 2005 23:06:49 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Linux 2.4.30-rc1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050318215513.GA25936@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_100_24582150.1111702009279"
References: <20050318215513.GA25936@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_100_24582150.1111702009279
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

On Fri, 18 Mar 2005 18:55:13 -0300, Marcelo Tosatti
<marcelo.tosatti@cyclades.com> wrote:
> 
> 
> Here goes the first release candidate for v2.4.30.

I'm a bit late, but here's a patch that fixes a module parameter
description typo in eepro100. The problem was located in the 2.6
source and a fix should be in 2.6-mm soon.

Thanks.

/ magnus

------=_Part_100_24582150.1111702009279
Content-Type: text/x-patch; name="linux-2.4.30-rc1-autoparam_eepro100.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="linux-2.4.30-rc1-autoparam_eepro100.patch"

--- linux-2.4.30-rc1/drivers/net/eepro100.c=092003-08-25 13:44:42.000000000=
 +0200
+++ linux-2.4.30-rc1-autoparam/drivers/net/eepro100.c=092005-03-24 22:13:46=
.563710568 +0100
@@ -153,8 +153,8 @@
 MODULE_PARM_DESC(congenb, "Enable congestion control (1)");
 MODULE_PARM_DESC(txfifo, "Tx FIFO threshold in 4 byte units, (0-15)");
 MODULE_PARM_DESC(rxfifo, "Rx FIFO threshold in 4 byte units, (0-15)");
-MODULE_PARM_DESC(txdmaccount, "Tx DMA burst length; 128 - disable (0-128)"=
);
-MODULE_PARM_DESC(rxdmaccount, "Rx DMA burst length; 128 - disable (0-128)"=
);
+MODULE_PARM_DESC(txdmacount, "Tx DMA burst length; 128 - disable (0-128)")=
;
+MODULE_PARM_DESC(rxdmacount, "Rx DMA burst length; 128 - disable (0-128)")=
;
 MODULE_PARM_DESC(rx_copybreak, "copy breakpoint for copy-only-tiny-frames"=
);
 MODULE_PARM_DESC(max_interrupt_work, "maximum events handled per interrupt=
");
 MODULE_PARM_DESC(multicast_filter_limit, "maximum number of filtered multi=
cast addresses");

------=_Part_100_24582150.1111702009279--
