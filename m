Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289007AbSA3KPr>; Wed, 30 Jan 2002 05:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289051AbSA3KPi>; Wed, 30 Jan 2002 05:15:38 -0500
Received: from MORGOTH.MIT.EDU ([18.238.2.157]:59009 "EHLO morgoth.mit.edu")
	by vger.kernel.org with ESMTP id <S289007AbSA3KP3>;
	Wed, 30 Jan 2002 05:15:29 -0500
Date: Wed, 30 Jan 2002 05:14:57 -0500
From: Alex Khripin <akhripin@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Replaces if(x) BUG() with BUG_ON(x)
Message-ID: <20020130101457.GA21996@morgoth.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch replaces most instances of
if(condition) BUG();
with
BUG_ON(condition);
taking advantage of the new API. Since it's a large patch (9000 lines)
it's available at http://web.mit.edu/akhripin/Public/bug_on_patch
-Alex Khripin
