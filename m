Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbTA3MZT>; Thu, 30 Jan 2003 07:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbTA3MZT>; Thu, 30 Jan 2003 07:25:19 -0500
Received: from comtv.ru ([217.10.32.4]:51849 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S267496AbTA3MZS>;
	Thu, 30 Jan 2003 07:25:18 -0500
X-Comment-To: "Andrey Borzenkov"
To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Cc: "Steven Dake" <sdake@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: New model for managing dev_t's for partitionable block devices
References: <E18eDGK-0002cr-00@f17.mail.ru>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 30 Jan 2003 15:34:11 +0300
In-Reply-To: <E18eDGK-0002cr-00@f17.mail.ru>
Message-ID: <m3znpierzw.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrey Borzenkov (AB) writes:


 AB> Are you aware of devfsd? It keeps permissions for you across
 AB> reboots, and does it just fine.

 AB> The real limitation in this case is SCSI host numbers. There is
 AB> no way to permanently assign logical controller numbers like it
 AB> happens in other systems. add or remove another SCSI adapter and
 AB> all your names are shifted.

 AB> which is true for any adapter not just SCSI.

one may use Inquiry/EVDP information from SCSI device


