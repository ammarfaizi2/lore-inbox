Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWCPGIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWCPGIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 01:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWCPGID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 01:08:03 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:40870 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S932674AbWCPGIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 01:08:01 -0500
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: jgarzik@pobox.com
Subject: re: [PATCH] AHCI SATA vendor update from VIA
Date: Thu, 16 Mar 2006 07:07:40 +0100
User-Agent: KMail/1.9.1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603160707.40986.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff,


I'd like to confirm that the patch in your email from 2005-12-11 does indeed 
work for my vt8251 on an K8M800 motherboard.

It didn't apply cleanly to 2.6.15; I had to fix two rejects, and then comment 
out the two lines with
	.host_stop =
and
	.check_err =
to make it compile.


I'd like to ask you if that could have negative effects, and when the driver 
(part) will be included in the standard kernel.


Thank you for this patch. I'm looking forward to your answer.


Regards,

Phil
