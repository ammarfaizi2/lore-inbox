Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263645AbUFFNs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUFFNs7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 09:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUFFNs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 09:48:59 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:2488 "EHLO mailfe01.swip.net")
	by vger.kernel.org with ESMTP id S263645AbUFFNs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 09:48:58 -0400
X-T2-Posting-ID: /sknEDxqgNYILdIqM8RWvsxa4S0yaaQlkxq/GXpTp0w=
From: jjluza <jjluza@yahoo.fr>
Reply-To: jjluza@yahoo.fr
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1 breaks forcedeth
Date: Sun, 6 Jun 2004 15:49:07 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406061549.07414.jjluza@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same problem here.
I use forcedeth too, and it doesn't work.
But like Vincent van de Camp said, I think the problem comes from ehci instead 
of forcedeth, and since they share the same irq, forcedeth is affected too.
You can see my report on bugzilla here :
http://bugzilla.kernel.org/show_bug.cgi?id=2799

If I can give more information, let me know (cc me, I'm not subscribed to this 
mailing list)
