Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281857AbRK1CEW>; Tue, 27 Nov 2001 21:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282999AbRK1CEN>; Tue, 27 Nov 2001 21:04:13 -0500
Received: from holomorphy.com ([216.36.33.161]:19888 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S281857AbRK1CED>;
	Tue, 27 Nov 2001 21:04:03 -0500
Date: Tue, 27 Nov 2001 18:03:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] earlier printk output
Message-ID: <20011127180342.A3921@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates console devices specifically for use during early
boot, and registers them so that printk() output may be seen prior
to console_init().

The patch is available from:

	ftp://ftp.kernel.org/pub/linux/kernel/people/wli/early_printk/


Included are i386 config options, early VGA text output, and early i386
serial output.


Cheers,
Bill
