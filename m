Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVGFRYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVGFRYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 13:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVGFRXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 13:23:04 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:24000 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261156AbVGFNAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:00:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EC/GOqZJHYXPpqSwpIfAnnRsFZZH6G1h1MlYBauSJ9tVCSEj7BiDnXEnNzM9lPaP5qsnYocDueASfGpF09cEqth0VENEO2yjL/eaEoSbeKG1syNnDV8vosd6tqPdtal2L2ShHo5l78mqvO42H3fKx06gENsEAb6TZChfGDpVRWU=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Rob Prowel <tempest766@yahoo.com>
Subject: Re: PROBLEM: please remove reserved word "new" from kernel headers
Date: Wed, 6 Jul 2005 17:06:29 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
In-Reply-To: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061706.29843.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 July 2005 13:26, Rob Prowel wrote:
> When kernel headers are included in compilation of c++
> programs the compile fails because some header files
> use "new" in a way that is illegal for c++.  This
> shows up when compiling mySQL under linux 2.6.  It
> uses $KERNELSOURCE/include/asm-i386/system.h.

Please read http://marc.theaimsgroup.com/?t=111637777000001&r=2&w=2
where people discuss this brokeness of MySQL.

