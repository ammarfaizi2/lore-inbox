Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWHQJPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWHQJPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWHQJPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:15:44 -0400
Received: from outgoing3.smtp.agnat.pl ([193.239.44.85]:18854 "EHLO
	outgoing3.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S932367AbWHQJPn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:15:43 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: qlogic 2312 problems on 2.6.16.22, 2.6.18rc4
Date: Thu, 17 Aug 2006 11:15:35 +0200
User-Agent: KMail/1.9.4
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200608140946.50411.arekm@pld-linux.org> <20060816181445.GU3674@andrew-vasquezs-computer.local> <200608162310.26541.arekm@pld-linux.org>
In-Reply-To: <200608162310.26541.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608171115.35522.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 23:10, Arkadiusz Miskiewicz wrote:

> Tyan manual ftp://ftp.tyan.com/manuals/m_s2891_100.pdf says on page 4
> ,,One PCI-X 100MHz slot (PCI-X B)''.
>
> Hm, while looking at that manual I see that on page 13 it says ,,one pci-x
> 100MHz device''. Maybe that's the problem since I didn't remove Adaptec
> TARO controller. I should be able to get this tested again without adaptec
> sooner than several weeks. Maybe I misunderstand what documentation says
> here.

The problem is solved now. Removing Adaptec controller from TARO slot makes 
system happy and there is no problem with qlogic card after that.

Weird mainboard. There should be warning with big letters on it ... 

Thanks for help!
-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
