Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTD2Kce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 06:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTD2Kce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 06:32:34 -0400
Received: from dsl-213-023-064-098.arcor-ip.net ([213.23.64.98]:10368 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP id S261312AbTD2Kcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 06:32:33 -0400
Date: Tue, 29 Apr 2003 12:44:34 +0200
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc1-ac3: unresolved symbol only with gcc-3.3
Message-ID: <20030429104434.GA19733@neon.pearbough.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

today I have successfully built 2.4.21-rc1-ac3 with gcc-3.2.3. Everything
was fine.
Then I built with gcc-3.3 and I encountered an error:

net/network.o(.text+0xdcd7): In function `rtnetlink_rcv':
: undefined reference to `rtnetlink_rcv_skb'

This build error only occurs with gcc-3.3.

Can somebody who knows the kernel look whether the error is legitimate or 
gcc is making errors.

Regards,
Axel Siebenwirth
