Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTLIAST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 19:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTLIAST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 19:18:19 -0500
Received: from may.nosdns.com ([207.44.240.96]:9448 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S262081AbTLIASR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 19:18:17 -0500
Date: Mon, 8 Dec 2003 17:18:10 -0700
From: "Russell \"Elik\" Rademacher" <elik@webspires.com>
X-Mailer: The Bat! (v2.00.6) Business
Reply-To: "Rusell \"Elik\" Rademacher" <elik@webspires.com>
X-Priority: 3 (Normal)
Message-ID: <098111156.20031208171810@webspires.com>
To: linux-kernel@vger.kernel.org
Subject: IPtables hang system when loading over 254 IP Addresses
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

  I was wondering if anyone have fixed or knew the slightly broken issue about loading the IPTables with Ingress/Egress filtering on 254 IP addresses or more?  It basically locks up the system in networking level but everything else works fine.

  Reason I asking is that I have quite a few servers with 256 to 300 IP addresses on it, which is mainly for the SSL or anonymous access. So..don't flame me for the gross IP misallocation on single server. :)

  Basically, if you knew about the script, APF Firewall script, I uses it and it make extensive uses of the IPTables to make complex firewall rules.  But when it reaches to around 254, it just locks up the network system, rendering the server unaccessible.  It make extensive uses of Ingress/Egress and I only seen it locks up when I make use of Egress filtering. Ingress works fine up to 400 IP addresses and I haven't pushed it that far past it to see how far it can go.  But Egress, it locks it up, when combined with Ingress.  Dunno about Egress itself in general.  So...anyone might have a clue on this?

  This is on 2.4.x series kernel.

-- 
Best regards,
Russell "Elik" Rademacher
Freelance Remote System Adminstrator/Tech Support    

