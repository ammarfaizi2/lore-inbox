Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271410AbTHRMI6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271407AbTHRMI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:08:58 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:1042 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S271384AbTHRMI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:08:56 -0400
Message-ID: <012b01c36581$6fd1c1b0$c801a8c0@llewella>
From: "Bas Bloemsaat" <bloemsaa@xs4all.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: <willy@w.ods.org>, <alan@lxorguk.ukuu.org.uk>, <carlosev@newipnet.com>,
       <lamont@scriptkiddie.org>, <davidsen@tmr.com>,
       <marcelo@conectiva.com.br>, <netdev@oss.sgi.com>,
       <linux-net@vger.kernel.org>, <layes@loran.com>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>
References: <20030728213933.F81299@coredump.scriptkiddie.org><200308171509570955.003E4FEC@192.168.128.16><200308171516090038.0043F977@192.168.128.16><1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk><200308171555280781.0067FB36@192.168.128.16><1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk><200308171759540391.00AA8CAB@192.168.128.16><1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk><200308171827130739.00C3905F@192.168.128.16><1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk><20030817224849.GB734@alpha.home.local><20030817223118.3cbc497c.davem@redhat.com> <20030818133957.3d3d51d2.skraw@ithnet.com>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Mon, 18 Aug 2003 14:08:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Replying again... Alan does mention in the paragraph you've quoted
> > to use arpfilter, which works for every case imaginable.
No it doesn't. When I have two nics on DHCP on the same ethernet segment, it
cannot be made to work. I don't know the ip addresses beforehand. And if if
I would get them with scripting and crafted some rules on the fly, there's
no way I can be sure I'll get the same IP's on a renew, so I'd have to check
often.

Regards,
Bas


