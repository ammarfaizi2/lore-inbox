Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVEXQVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVEXQVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVEXQVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:21:39 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:6671 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262112AbVEXQVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:21:33 -0400
Message-ID: <4293548B.2000100@rtr.ca>
Date: Tue, 24 May 2005 12:21:31 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Ivan G <g-i-v@rambler.ru>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: DMA not works in Linux 2.6.12, but in Windows works fine.
References: <web-135595327@mail5.rambler.ru> <20050523193010.5bf72481.vsu@altlinux.ru> <42922232.90206@pobox.com>
In-Reply-To: <42922232.90206@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note to others:

If you are brave and pull down Jeff's libata-dev tree,
then it already has ATAPI DMA working (mostly) therein.

That's what I've done on my newest ICH6M machine here,
and both the PATA HD and PATA DVD-RW are working just fine
in "combined mode" using ata_piix.  After applying a bugfix
patch for ATAPI error handling (which Jeff has just posted
here today somewhere for general comments).

Cheers.
