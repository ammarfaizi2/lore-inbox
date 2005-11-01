Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVKASDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVKASDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVKASDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:03:45 -0500
Received: from mail0.lsil.com ([147.145.40.20]:58581 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751073AbVKASDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:03:44 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C04BE82D0@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Martin Devera <devik@cdi.cz>, linux-kernel@vger.kernel.org
Cc: phil@icglink.com, akpm@osdl.org, "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       Holger.Kiehl@dwd.de, James.Bottomley@SteelEye.com,
       artur.kedzierski@navy.mil
Subject: RE: Fusion-MPT slowness workaround
Date: Tue, 1 Nov 2005 11:02:36 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 01, 2005 10:46 AM,  Martin Devera wrote:
> because I ran into problem with fusion mpt scsi with 2.6.14 yesterday
> I tried to find a workaround.
> Because it seems that there is bug in DV code I patched driver to skip
> DV and use firmware negotiation data.
> It "works for me" both compiled-in and as module.
> 

NACK. Disabling DV is not the solution.

I have a fix I will post sometime this week.

Eric Moore
