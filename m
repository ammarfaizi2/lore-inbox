Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbTFQWbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTFQWbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:31:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48090 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264979AbTFQWbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:31:13 -0400
Date: Tue, 17 Jun 2003 15:40:37 -0700 (PDT)
Message-Id: <20030617.154037.78070671.davem@redhat.com>
To: jamagallon@able.es
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCHES] 2.4.x net driver updates
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030617222750.GE13990@werewolf.able.es>
References: <20030612194926.GA7653@gtf.org>
	<20030617222750.GE13990@werewolf.able.es>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "J.A. Magallon" <jamagallon@able.es>
   Date: Wed, 18 Jun 2003 00:27:50 +0200

   Any info about the RX_POLLING (NAPI) option for e1000 ?
   What is that for ?

Software based interrupt mitigation, see:

Documentation/networking/NAPI_HOWTO.txt

and more specifically:

http://www.cyberus.ca/~hadi/usenix-paper.tgz

