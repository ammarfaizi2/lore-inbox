Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbVIOFEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVIOFEs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 01:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVIOFEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 01:04:48 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:6571 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965154AbVIOFEr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 01:04:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gy0F/OS4sXKU3zJvNDOQaTEQH0kaJ48SpskGObDNcTY5hcggkVWMQiPpx3TSKUExmUngyijXgvXGB4k1+fT/jQEYffPIY1+TrWELWpgTjSqkdhZNGQJ2Ihdz5ccfyxWz444IBu18HBMpxFQv1AFHEiU1xKaPlPWh5bDoeiPUBJw=
Message-ID: <355e5e5e050914220444505b09@mail.gmail.com>
Date: Thu, 15 Sep 2005 01:04:42 -0400
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: lkosewsk@gmail.com
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.6.14-rc1 0/3] Add disk hotswap support to libata RESEND #3
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff, all,

Another attempt at hotswap support to libata... this would be attempt #3.

Lots of improvements... a cleaner API, clean straightforward code
which is easy to customize (or generalize, when the desire to support
ATA hotswap comes along), and a new feature; no longer kernel panics
on any action!

Some testing on x86 UP, minimal on SMP.  Please test, send questions,
suggestions, and apply if you like it.  Patches apply cleanly to
2.6.14-rc1.  I've got some hardware so if you discover problems I can
probably reproduce them.

Enjoy,

Luke Kosewski
