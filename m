Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWIZFSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWIZFSs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWIZFSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:18:48 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:17373 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751107AbWIZFSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:18:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AgmBpcJrjOMkQ+vphZ3odTQ14jAO70XUpCKOkSY5hyI2oOHxe0NokYVo7HqBy+84RgrDTZsZim+g7bxKvZ/GjJ4iHUzjBdtAiJ9tTtYzh1DQIDY7GJL/dCZI8Qc4JG5hrzYy/znyMFmmz6VIM+egiqn6Qkm6QK31G0gWPpnVyo4=
Message-ID: <4518B831.8060109@gmail.com>
Date: Tue, 26 Sep 2006 14:18:41 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: "qc timeout" error in sata_sil 3114 driver, 2.6.18
References: <45144D3D.4010400@freescale.com>
In-Reply-To: <45144D3D.4010400@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc'ing linux-ide]

Timur Tabi wrote:
> I'm working on a new PowerPC board (8349 based) with a Silicon Image 
> 3114 SATA controller
> connected to a Hitachi drive.  When the sata_sil driver loads and tries 
> to find the device,
> I get "qc timeout" errors.  I don't know a lot about SATA.  Can anyone 
> give me a clue as
> to what could be wrong?

Several questions.

1. does any previous kernel version work?  say, 2.6.17?
2. can your ppc board do byte-aligned mmio access?
3. it could be irq routing problem.  can you verify that?

-- 
tejun
