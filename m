Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUHEWqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUHEWqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267906AbUHEWql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:46:41 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:33799 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268039AbUHEWpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:45:52 -0400
To: Andi Kleen <ak@muc.de>
Cc: "Michael Chan" <mchan@broadcom.com>, linux-kernel@vger.kernel.org
Subject: Re: MMCONFIG violates pci power mgmt spec
X-Message-Flag: Warning: May contain useful information
References: <2pYrs-17y-31@gated-at.bofh.it>
	<m3brhp8biw.fsf@averell.firstfloor.org>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 05 Aug 2004 15:45:50 -0700
In-Reply-To: <m3brhp8biw.fsf@averell.firstfloor.org> (Andi Kleen's message
 of "Fri, 06 Aug 2004 00:28:55 +0200")
Message-ID: <52pt65fbkx.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Aug 2004 22:45:50.0445 (UTC) FILETIME=[F4DB49D0:01C47B3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> If someone cites the spec that says that it is not allowed I
    Andi> guess it could be removed.

I believe the PCI Express spec says that config writes are never posted.
(I'll check later to be sure)

 - Roland
