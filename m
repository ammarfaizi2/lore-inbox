Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTGASqk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTGASqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:46:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63692 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263365AbTGASqj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:46:39 -0400
Message-ID: <3F01DA62.9080707@pobox.com>
Date: Tue, 01 Jul 2003 15:00:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Mock <jeff-ml@mock.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.21 ICH5 SATA related hang during boot
References: <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com> <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com> <5.1.0.14.2.20030701114153.060dd098@mail.mock.com>
In-Reply-To: <5.1.0.14.2.20030701114153.060dd098@mail.mock.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mock wrote:
> With this new change does the BIOS (on an Intel 875P / ICH5
> motherboard) still need the drives to be set to legacy mode, or can
> it be set to enhanced mode to access the full complement of SATA
> and PATA devices?

Yep, you can enable enhanced (also called native) mode for SATA, to get 
the full spread of 6 devices normally possible (4 pata + 2 sata).

	Jeff



