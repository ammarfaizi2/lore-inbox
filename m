Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUFOVr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUFOVr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUFOVr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:47:26 -0400
Received: from ciistr1.ist.utl.pt ([193.136.128.1]:22170 "EHLO
	ciistr1.ist.utl.pt") by vger.kernel.org with ESMTP id S265970AbUFOVqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:46:30 -0400
From: Claudio Martins <ctpm@ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: 3ware 9500S Drivers (mm kernel)
Date: Tue, 15 Jun 2004 22:42:07 +0100
User-Agent: KMail/1.6.2
Cc: "Peter Maas" <fedora@rooker.dyndns.org>
References: <001101c4531c$7a7c6960$3205a8c0@pixl>
In-Reply-To: <001101c4531c$7a7c6960$3205a8c0@pixl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406152242.07392.ctpm@ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 15 June 2004 22:05, Peter Maas wrote:
>
> My only complaints with the drivers are that smartctl doesnt work with them
> (fedora core 2), and the 3ware management tools from the 3ware cd wont work
> with the mm drivers (wont detect controller).
>

  By the way, right now smartctl doesn't seem to work at all with SATA using 
the libata drivers, because AFAIK libata hasn't been taught to pass through 
the required S.M.A.R.T commands to the drive yet.

  Does anyone know how difficult is this to code, or if it is necessary to 
change the scsi layer as well as libata? I'm willing to assist in testing any 
patches to add the possibility of using smartmontools with libata drivers.

 Regards

Claudio

