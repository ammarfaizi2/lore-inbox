Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbULZUu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbULZUu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 15:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbULZUu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 15:50:59 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:32490 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261161AbULZUuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 15:50:55 -0500
Date: Sun, 26 Dec 2004 21:50:54 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.{9,10}: C3 not working once USB driver gets loaded (ThinkPad T40p)
Message-ID: <20041226205053.GA27671@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In recent kernels (tried 2.6.9, 2.6.10), after I load the uhci_hcd module,
the processor never goes to state C3.  Unloading the module again puts things
back to normal.  The system is an IBM ThinkPad T40p.

Is the USB driver setting some kinda flag in the ACPI subsystem to achieve
this behavior intentionally or is this a bug?

Thanks,
-- 
Tomas Szepe <szepe@pinerecords.com>
