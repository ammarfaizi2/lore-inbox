Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTDPQdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTDPQdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:33:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32708
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264447AbTDPQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:33:28 -0400
Subject: Re: firmware separation filesystem (fwfs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ranty@debian.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030416163641.GA2183@ranty.ddts.net>
References: <20030416005710.GB29682@ranty.ddts.net>
	 <1050492681.28586.39.camel@dhcp22.swansea.linux.org.uk>
	 <20030416144631.GB899@zax>  <20030416163641.GA2183@ranty.ddts.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050508028.28586.126.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 16:47:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 17:36, Manuel Estrada Sainz wrote:
>  On the other hand, there are already many drivers in the kernel that
>  include firmware in headers, keyspan, io_edgeport, dabusb, ser_a2232,
>  sym53c8xx_2, ...

But so would loading it from hotplug via ioctl. It might be we want
a clean hotplug way to ask for 'firmare for xyz'.


