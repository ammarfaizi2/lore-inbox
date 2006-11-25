Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967270AbWKYWbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967270AbWKYWbl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 17:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967269AbWKYWbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 17:31:41 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:11204 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967264AbWKYWbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 17:31:40 -0500
X-Sasl-enc: 57AwE1Bpd3iJpz/pVJPCLiznTpgzPTRjzqvRrVDh5kOn 1164493900
Date: Sat, 25 Nov 2006 20:31:28 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       len.brown@intel.com, linux-acpi@vger.kernel.org
Subject: Re: [2.6 patch] proper prototype for drivers/base/init.c:driver_init()
Message-ID: <20061125223128.GN1537@khazad-dum.debian.net>
References: <20061125191645.GI3702@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125191645.GI3702@stusta.de>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006, Adrian Bunk wrote:
> This patch adds a prototype for driver_init() in include/linux/device.h.
> 
> It also removes a static function of the same name in 
> drivers/acpi/ibm_acpi.c to ibm_acpi_driver_init() to fix the namespace 
> collision.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

ACK for the proposed ibm-acpi changes (I can't speak for driver_init).  A
full namespace cleanup in ibm-acpi will touch pretty much every function in
the ibm-acpi driver, so it will have to wait until a bunch of patches that I
just submitted for acpi-test are either merged or rejected.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
