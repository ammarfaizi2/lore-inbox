Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbTGOLGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTGOLGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:06:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48325
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S267168AbTGOLGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:06:38 -0400
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David griego <dagriego@hotmail.com>
Cc: jgarzik@pobox.com, dsaxena@mvista.com, alan@storlinksemi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Sea2-F66GGORm1u51rM00012573@hotmail.com>
References: <Sea2-F66GGORm1u51rM00012573@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058267923.3845.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2003 12:18:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-15 at 00:26, David griego wrote:
> >Are these common cases to be optimized for latency or throughput?
> I would personaly see the common case optimized for throughput on large 
> packets, and allow the smaller packets to be processed by the OS.

Its very very application dependant. Latency is critical to a good file
server, although storage people often like to handwave those numbers
away (not all of them thankfully)

Cluster people want low latency at all times, and latency is the one
thing that is almost impossible to recover once you lose time to it

