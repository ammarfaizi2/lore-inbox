Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273440AbRI3M4a>; Sun, 30 Sep 2001 08:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273442AbRI3M4U>; Sun, 30 Sep 2001 08:56:20 -0400
Received: from [195.72.14.134] ([195.72.14.134]:32776 "HELO ipv6.isternet.sk")
	by vger.kernel.org with SMTP id <S273440AbRI3M4C>;
	Sun, 30 Sep 2001 08:56:02 -0400
Date: Sun, 30 Sep 2001 14:56:27 +0200
From: Jan Oravec <wsx@wsx6.net>
To: linux-kernel@vger.kernel.org
Subject: IPv6 neighbor solicitation -> no response
Message-ID: <20010930145627.A32407@ipv6.isternet.sk>
Reply-To: Jan Oravec <wsx@wsx6.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: UNIX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


After upgrade from 2.2 to 2.4 kernel machine stopped answering IPv6 neighbor solicitation requests on pointtopoint interfaces.

Response from machine running 2.2 kernel:

14:50:05.762924 fe80::201:2ff:fe0f:b5a2 > fe80::3e8c:1d09: icmp6: neighbor sol: who has fe80::3e8c:1d09
14:50:05.810325 fe80::3e8c:1d09 > fe80::201:2ff:fe0f:b5a2: icmp6: neighbor adv: tgt is fe80::3e8c:1d09

After upgrade to 2.4 kernel, I do not receive any answer from fe80::3e8c:1d09. Routing, etc. works without it perfectly, but for example OSPF6 daemon does not.


Best Regards,

-- 
Jan Oravec<wsx@wsx6.net> PGP:www.wsx6.net/pgp-key.txt IRC:WSX
+-------- XS26 --------+- Postal address -+----- PHONE -----+
| XS26.NET Coordinator | Jan Oravec       |       GSM       |
|   'Access to IPv6'   | Bernolakova 36   | +421-903-316905 |
| jan.oravec@xs26.net  | Banska Bystrica  |     PRIVATE     |
| http://www.xs26.net  | 974 05, Slovakia | +421-48-4103796 |
+----------------------+------------------+-----------------+
