Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTHVMdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTHVMby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:31:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19207 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263075AbTHVL1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 07:27:11 -0400
Date: Fri, 22 Aug 2003 12:27:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Bill J.Xu" <xujz@neusoft.com>
Cc: Charles Lepple <clepple@ghz.cc>, linux-kernel@vger.kernel.org
Subject: Re: "ctrl+c" disabled!
Message-ID: <20030822122704.A12903@flint.arm.linux.org.uk>
Mail-Followup-To: "Bill J.Xu" <xujz@neusoft.com>,
	Charles Lepple <clepple@ghz.cc>, linux-kernel@vger.kernel.org
References: <036601c367e0$01adabc0$2a01010a@avwindows> <3F457A19.8E8A1F65@gmx.de> <04b901c36852$dccc7660$2a01010a@avwindows> <3F45830A.5C0F5BCA@gmx.de> <053301c3685c$9ea6fe50$2a01010a@avwindows> <bi45b6$kor$1@sea.gmane.org> <05a501c36869$a7aeee60$2a01010a@avwindows>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <05a501c36869$a7aeee60$2a01010a@avwindows>; from xujz@neusoft.com on Fri, Aug 22, 2003 at 12:55:48PM +0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 12:55:48PM +0800, Bill J.Xu wrote:
> Yeah,that is the result after pressing ctrl+c, ctrl+d. maybe od do not get the "ctrl+c" signal.
> But I use SecureCRT with the same configration at the same PC to telnet the linux box,everything is OK.
> So I think that if there is some thing wrong with linux kernel?

Check /proc/tty/driver/serial for framing errors.

Also check that both ends of your serial link are appropriately configured.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

