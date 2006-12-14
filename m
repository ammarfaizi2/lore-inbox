Return-Path: <linux-kernel-owner+w=401wt.eu-S1751937AbWLNBXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWLNBXb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWLNBXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:23:31 -0500
Received: from web50107.mail.yahoo.com ([206.190.38.35]:24146 "HELO
	web50107.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751937AbWLNBXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:23:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=HISfbQttUt9ypFHnH1SQJud7p+uIXvDo8ZGqt+ZNRbzl+c1OnYcgE+VJFni5l7NT7FHTNyGYPv/H5q3V3kSLGGS3JgAc9GgCUxBhZDAZdxVa0FeO4rtqxSQkbjXRiDqmGfab0/3rHQ5O2C3KlP/TY8PytzYkvd1aEtHdim7qaKA=;
X-YMail-OSG: gCqN.zAVM1njA.bkQuVqno7Q8LacZ3vIXB7PdpAdtQ.g.8zw9r6RD4ROU1Fjlf34BlzbMGiOMsvwajWCt2a7UvmdOf99Dg29I_nuoe4aDamQ2LD4Kk2Nq0MYvI2BtTz7STMSll38fw--
Date: Wed, 13 Dec 2006 17:16:48 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 0/3] EDAC: Fixes and new features for EDAC CORE
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <44151.29660.qm@web50107.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following 3 patches consist of 1 fix in the E752x driver and 2 new
features. 

The new features are:

1) New EDAC interface for programming memory scrub rates in
memory controller drivers that choose to implement the 
scrubrate function

2) Support in the EDAC CORE for Fully Buffered DIMMs (FB-DIMMs)
A MC driver for the Intel 5000X/V/P chipset is forthcoming, which
requires these EDAC CORE API additions.

doug thompson <norsk5@xmission.com>


