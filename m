Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTDWIPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 04:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbTDWIPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 04:15:36 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:1023 "HELO
	vaxjo.synopsys.com") by vger.kernel.org with SMTP id S263986AbTDWIPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 04:15:35 -0400
Date: Wed, 23 Apr 2003 10:27:27 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.86+: sizes of almost all files in sysfs are 4k?
Message-ID: <20030423082727.GE890@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This confuses some applications (i.e., the midnight commander).

Was this intended?
If the size is not simple/possible to calculate, maybe using 0
would be an option for the cases where the size doesn't carry
any information (like in procfs)?

-alex
