Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264554AbUDVQjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264554AbUDVQjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264520AbUDVQjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:39:45 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:23271 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264513AbUDVQjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:39:42 -0400
Subject: Re: Why is CONFIG_SCSI_QLA2X_X always enabled?
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Kieran <kieran@ihateaol.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040422092853.55d0b011.rddunlap@osdl.org>
References: <4087E95F.5050409@ihateaol.co.uk> 
	<20040422092853.55d0b011.rddunlap@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 Apr 2004 12:39:34 -0400
Message-Id: <1082651974.1778.52.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 12:28, Randy.Dunlap wrote:
> A nuisance or annoyance perhaps.  Here's a patch for it.

No, it's a variable used to determine whether the user should be asked
about qla2xxx or not.

The proposed patch is obviously not correct, because we don't want the
user to be asked about it.

A better fix might be to make the qla2xxx a menu dependent on SCSI &&
PCI

James


