Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUGFU1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUGFU1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUGFU1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:27:33 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:34210 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264367AbUGFU12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:27:28 -0400
Message-ID: <40EB0AE7.40803@blue-labs.org>
Date: Tue, 06 Jul 2004 16:26:15 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Nivedita Singhvi <niv@us.ibm.com>, shemminger@osdl.org, ahu@ds9a.nl,
       acme@conectiva.com.br, netdev@oss.sgi.com, alessandro.suardi@oracle.com,
       phyprabab@yahoo.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org>	<20040629222751.392f0a82.davem@redhat.com>	<20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>	<20040630153049.3ca25b76.davem@redhat.com>	<20040701133738.301b9e46@dell_ss3.pdx.osdl.net>	<20040701140406.62dfbc2a.davem@redhat.com>	<20040702013225.GA24707@conectiva.com.br>	<20040706093503.GA8147@outpost.ds9a.nl>	<20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>	<40EB04C7.4000007@us.ibm.com> <20040706131617.39484eff.davem@redhat.com>
In-Reply-To: <20040706131617.39484eff.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060801060905010902050409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060801060905010902050409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It's been a while since I used a 1460 MTU for PPTP over DSL, but unless 
OSDN got a clue recently, their firewalls drop the ICMP for PMTU 
discovery.  Does anyone have a tool that exercises a bunch of TCP/IP 
options to detect such broken firewalls?

David

David S. Miller wrote:

>[...]
>Frankly, I've personally seen none of this.  I sit on a DSL line with
>no firewalling at my end and I can access all sites just fine.  This
>seems to indicate that most of the breakage is local to the user's
>point of access to the net, rather than a firewall at google.com
>or kernel.org or similar.
>

--------------060801060905010902050409
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------060801060905010902050409--
