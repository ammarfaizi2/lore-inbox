Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVAUOLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVAUOLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 09:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVAUOLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 09:11:11 -0500
Received: from levante.wiggy.net ([195.85.225.139]:19863 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262370AbVAUOLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 09:11:08 -0500
Date: Fri, 21 Jan 2005 15:11:06 +0100
From: Wichert Akkerman <wichert@attingo.nl>
To: linux-kernel@vger.kernel.org
Subject: negative diskspace usage
Message-ID: <20050121141106.GG7147@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After cleaning up a bit df suddenly showed interesting results:

Filesystem            Size  Used Avail Use% Mounted on
/dev/md4             1019M  -64Z  1.1G 101% /tmp

Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/md4               1043168 -73786976294838127736   1068904 101% /tmp

This is on a ext3 filesystem on a 2.6.10-ac10 kernel.

Wichert.

-- 
Wichert Akkerman <wichert@attingo.nl> | Technical Manager
Phone: +31 620 607 695                | Attingo, airport internet services
Fax:   +31 30 693 2557                | http://www.attingo.nl/
