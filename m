Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131352AbRC0Pdx>; Tue, 27 Mar 2001 10:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131361AbRC0Pdn>; Tue, 27 Mar 2001 10:33:43 -0500
Received: from geos.coastside.net ([207.213.212.4]:58343 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S131352AbRC0Pdj>; Tue, 27 Mar 2001 10:33:39 -0500
Mime-Version: 1.0
Message-Id: <p05100801b6e661f7a5cc@[207.213.214.34]>
In-Reply-To: <3AC09480.E8317507@evision-ventures.com>
In-Reply-To: <l03130332b6e632432b9f@[192.168.239.101]>
 <3AC09480.E8317507@evision-ventures.com>
Date: Tue, 27 Mar 2001 07:31:41 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: OOM killer???
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki <dalecki@evision-ventures.com> writes:

>Plase change to 100 to 500 - this would make it consistant with
>the useradd command, which starts adding new users at the UID 500

It's probably best to keep it somewhere <500, so that one can have "static" (<500) UIDs of either flavor: OOM-killable or not. 100 seems like "enough" non-killable users to me, but that may be a lack of imagination on my part.

-- 
/Jonathan Lundell.
