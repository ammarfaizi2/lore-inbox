Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933685AbWKQQRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933685AbWKQQRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933694AbWKQQRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:17:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:44806 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933685AbWKQQRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:17:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=dnPJVZt5dYkxFY9PPApwZn/XltSfQElK30QqaG+Lk6z3+oay8AB+whN8rUt2vK3ZqgV+81P/Pfx+6nqiEj43xR38bNTQd8A5iDbI/4OGOLbzaHz4rTbHJ43iPU+fWCWFxhIKrtiR5lMNgUhdS/Y2uNO6ZVEYbx+kRl2z/W5a/hY=
Message-ID: <86802c440611170817i4452ae9ctb6d57f0879e877af@mail.gmail.com>
Date: Fri, 17 Nov 2006 08:17:04 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Takashi Iwai" <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Cc: "Olivier Nicolas" <olivn@trollprod.org>, "Jeff Garzik" <jeff@garzik.org>,
       "David Miller" <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5hwt5us5q2.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	 <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	 <20061114.192117.112621278.davem@davemloft.net>
	 <s5hbqn99f2v.wl%tiwai@suse.de> <455B5D22.10408@garzik.org>
	 <s5hslgktu4a.wl%tiwai@suse.de> <455B6761.3050700@garzik.org>
	 <s5hodr7u0ve.wl%tiwai@suse.de> <455CEDC5.40200@trollprod.org>
	 <s5hwt5us5q2.wl%tiwai@suse.de>
X-Google-Sender-Auth: 885dcb0e967d243c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the fallback path from MSI test to ioapic still not look good.

I think you could seperate azx_interrupt_test later.

It seems on C51+MCP55 has problem to use MSI for hda.
and I have tried two MCP55 only systems, the MSI for hda works well.

YH
