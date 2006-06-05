Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751036AbWFEMOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWFEMOL (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWFEMOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:14:11 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:17106 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750947AbWFEMOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:14:10 -0400
Date: Mon, 5 Jun 2006 09:14:09 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: dwmw2@infradead.org, rmk@arm.linux.org.uk, gregkh@suse.de,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        zaitcev@redhat.com
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-ID: <20060605091409.15e69852@doriath.conectiva>
In-Reply-To: <20060604162453.696f190b.zaitcev@redhat.com>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	<20060601234833.adf12249.zaitcev@redhat.com>
	<1149242609.4695.0.camel@pmac.infradead.org>
	<20060602154723.54704081.zaitcev@redhat.com>
	<20060604201223.7cd37936@home.brethil>
	<20060604162453.696f190b.zaitcev@redhat.com>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 16:24:53 -0700
Pete Zaitcev <zaitcev@redhat.com> wrote:

| On Sun, 4 Jun 2006 20:12:23 -0300, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
| 
| > | I understand. My intent was different, however. One of the bigger sticking
| > | points for usb-serial was its interaction with line disciplines, which are
| > | notorious for looping back and requesting writes from callbacks
| > | (e.g. h_hdlc.c). They are also sensitive to drivers lying about the
| > | amount of free space in their FIFOs. This is something you never test
| > | when driving a serial port from an application, no matter how cleverly
| > | written.
| 
| >   In all the tests the modem was configured to answer the calls, and the
| > cell phone was configured to dial to the modem (my home's number).
| 
| This is exactly backwards, and so it tests different code paths.
| The line discipline is involved into driving a cooked mode port,
| e.g. the one where getty is.

 I was going to try it last night and realized that my cell phone
can't answer data calls. :((

-- 
Luiz Fernando N. Capitulino
