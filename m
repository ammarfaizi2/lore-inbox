Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292395AbSCICYH>; Fri, 8 Mar 2002 21:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292415AbSCICX6>; Fri, 8 Mar 2002 21:23:58 -0500
Received: from jhuml4.jhu.edu ([128.220.2.67]:47253 "EHLO jhuml4.jhu.edu")
	by vger.kernel.org with ESMTP id <S292395AbSCICXq>;
	Fri, 8 Mar 2002 21:23:46 -0500
Date: Fri, 08 Mar 2002 21:24:46 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: PnP BIOS driver status
In-Reply-To: <E16jWYf-0008Q4-00@the-village.bc.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Message-id: <1015640686.941.44.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: text/plain
Content-transfer-encoding: 7bit
In-Reply-To: <E16jWYf-0008Q4-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-08 at 21:26, Alan Cox wrote:
> Got you - yes Thomas he's absolutely right. The lock needs to be
> taken by the callers before they set the PNP_TS* entries. 

Yep.  I'll submit a patch to Alan and update the one I just
posted for DJ.

--
Thomas

