Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTBEPAW>; Wed, 5 Feb 2003 10:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTBEPAW>; Wed, 5 Feb 2003 10:00:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8859
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261451AbTBEPAV>; Wed, 5 Feb 2003 10:00:21 -0500
Subject: Re: Help with promise sx6000 card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Lists <user_linux@citma.cu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5E3AE650.2010208@citma.cu>
References: <20030203221923.M79151@webmail.citma.cu>
	 <1044360902.23312.16.camel@irongate.swansea.linux.org.uk>
	 <5E3AE650.2010208@citma.cu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044461220.32062.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 05 Feb 2003 16:07:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 15:59, Linux Lists wrote:
> OK, but what i have to do to load the modules in that order
> 

Either build a kernel with them built in or run mkinitrd with the option

--preload=i2o_core --preload=i2o_pci --preload=i2o_block.

The Red Hat installer builds a wrongly ordered initrd for i2o stuff in
8.0. Thats fixed in the beta but doesn't help you.


