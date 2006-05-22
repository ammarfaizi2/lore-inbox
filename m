Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWEVTgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWEVTgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWEVTgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:36:41 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:35426 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751155AbWEVTgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:36:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SWfyCBiKSblFOpjJdLs6keP/SD1DLG+dlzl1OjIWN475UD3DWOWOYApxEjUXTU6BOZr6Z/VJUHX23oEgo3bfeHHmYqZlVBpChDd7tCr+e0whJFpK5g97nDHEq6Wbdz4q4Bla/ZxyV0AxXvdZvumfbz6lEV2VgwET1/P37kXlr+k=
Message-ID: <447212C1.403@gmail.com>
Date: Mon, 22 May 2006 13:36:33 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Laurent Riffard <laurent.riffard@free.fr>
CC: Kernel development list <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc1-mm3: time-i386-clocksource-drivers*.patch broke userspace
 apps
References: <4454B4A1.4060304@free.fr>
In-Reply-To: <4454B4A1.4060304@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard wrote:
> Hello,
>
> Since 2.6.17-rc1-mm3, some applications behave strangely here:
> - video players (mplayer, vlc) are randomly frozen after less than 1
> minute playing . They are killable by ^C.
> - some network java application (freenet-0.7) quit after a few
> minutes running.
>
> A bissection point out time-i386-clocksource-drivers.patch as the
> sucker.
>
> I noticed that, since 2.6.17-rc1-mm3, pit clocksource is installed
> instead of acpi_pm clocksource. Booting with "clocksource=acpi_pm"
> does not help.
>
>   


> Is pit clocksource broken ? If so, how can I get back acpi_pm
> clocksource ?
>
>   
Followup on the 1st Q:
GTS v.C2 had some pit fixes, what happens now testing with clocksource=pit ?

