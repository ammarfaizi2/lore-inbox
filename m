Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbULGUm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbULGUm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbULGUm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:42:26 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:38016
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S261906AbULGUmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:42:24 -0500
Date: Tue, 7 Dec 2004 12:42:23 -0800
From: Phil Oester <kernel@linuxace.com>
To: Ronald Moesbergen <r.moesbergen@hccnet.nl>
Cc: paulkf@microgate.com, mail@kirya.ru,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ppp][2.6.10-rc3] Don't work pppd.
Message-ID: <20041207204223.GA26238@linuxace.com>
References: <41B60EE3.4070400@hccnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B60EE3.4070400@hccnet.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 09:13:23PM +0100, Ronald Moesbergen wrote:
> I've got the same problem but with pptp-client (pptpclient.sf.net). I 
> did a binary search and found that with the same kernel and pptp config, 
> kernel 2.6.10-rc2-bk13 works, and 2.6.10-rc2-bk14 doesn't. Hope that 
> helps to narrow it down. Let me know if there is anything I can try.

Read the archives...a patch was submitted to fix this today -- look for
select().

Phil
