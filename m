Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271600AbRIOAKN>; Fri, 14 Sep 2001 20:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271598AbRIOAKD>; Fri, 14 Sep 2001 20:10:03 -0400
Received: from [209.202.108.240] ([209.202.108.240]:9484 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S271597AbRIOAJs>; Fri, 14 Sep 2001 20:09:48 -0400
Date: Fri, 14 Sep 2001 20:09:54 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2 IDE cd-roms + ide-scsi = 4 scsi cdroms ???
In-Reply-To: <3BA299D7.55F6C2D6@torque.net>
Message-ID: <Pine.LNX.4.33.0109142008390.398-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, Douglas Gilbert wrote:

> Joseph,
> Try turning off CONFIG_SCSI_MULTI_LUN in your kernel
> config and recompile your kernel (or modules in your case
> because lsmod shows all your scsi components are modules).
>
> This will stop 2 luns being seen for each actual
> device.

So then here's a question:

Why does the ide-scsi driver provide 2 LUN's? I can understand in the case of
changers/jukeboxes, but why for single-disc drives?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

