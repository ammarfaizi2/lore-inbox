Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbTKMTEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 14:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTKMTEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 14:04:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44947 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264385AbTKMTEf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 14:04:35 -0500
Message-ID: <3FB3D5B1.5080904@pobox.com>
Date: Thu, 13 Nov 2003 14:04:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Holmes <jholmes@psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make 2.6 megaraid recognize intel vendor id
References: <3FB3BBE0.D4D0EACC@psu.edu>
In-Reply-To: <3FB3BBE0.D4D0EACC@psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Holmes wrote:
> Hi,
> 
> The 2.4 megaraid driver recognizes the Intel PCI vendor id whereas the
> 2.6 driver does not.  The attached patch against 2.6.0-test9 adds the
> missing two lines from the 2.4 driver to enable this.


ewwww.

I don't object to your patch, but I'm disappointed that megaraid doesn't 
use the normal PCI probing mechanism.

	Jeff


