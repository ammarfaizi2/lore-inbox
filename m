Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbTIJSL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265454AbTIJSL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:11:27 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:35949 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265406AbTIJSLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:11:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Fawad Halim <fawad@fawad.net>, linux-kernel@vger.kernel.org
Subject: Re: Linksys connectivity problem using 2.6.0-test4
Date: Wed, 10 Sep 2003 13:11:20 -0500
User-Agent: KMail/1.5.3
References: <3F5F0F2C.5080407@fawad.net>
In-Reply-To: <3F5F0F2C.5080407@fawad.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309101311.20196.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 September 2003 06:46 am, Fawad Halim wrote:
> Hi,
>     I'm having trouble connecting to the http based admin ports on my
> LinkSys VPN router (BEFVP41) using the 2.6.0-test4 kernel on Redhat 9.
> The connectivity works fine with 2.4.20-19.9 from Redhat as well as
> other 2.4.x kernels. With the 2.6 kernel, I can ping the machine, but
> can't connect to the http ports (80, 8080)
>
<skip>
> # telnet 192.168.3.1 80
> Trying 192.168.3.1...
> telnet: connect to address 192.168.3.1: Connection refused
>
> The VPN router is doing NAT correctly for both kernels, and connectivity
> to services other than the router itself is fine.
>

Make sure that you not using ECN - my Linksys refuses incoming
connections with ECN. Passes them tohrough just fine, tough.

Dmitry
