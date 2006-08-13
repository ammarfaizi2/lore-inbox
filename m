Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWHMEsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWHMEsn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 00:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWHMEsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 00:48:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:52711 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030194AbWHMEsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 00:48:42 -0400
From: Andi Kleen <ak@suse.de>
To: linux-arch@vger.kernel.org
Subject: module compiler version check still needed?
Date: Sun, 13 Aug 2006 06:48:36 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608130648.36178.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does anybody know of any reason why we would still need the compiler version
check during module loading? AFAIK on i386 it was only needed to handle
2.95 (which got dropped) and on x86-64 it was never needed. Is there
a need on any other architecture for it?

-Andi
