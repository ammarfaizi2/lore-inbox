Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269576AbUJLJjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269576AbUJLJjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbUJLJjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:39:52 -0400
Received: from zamok.crans.org ([138.231.136.6]:28805 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S269576AbUJLJjM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:39:12 -0400
To: sboyce@blueyonder.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 Oops [2]
References: <416B9517.7010708@blueyonder.co.uk>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Tue, 12 Oct 2004 11:39:11 +0200
In-Reply-To: <416B9517.7010708@blueyonder.co.uk> (Sid Boyce's message of "Tue,
	12 Oct 2004 09:25:59 +0100")
Message-ID: <877jpwi8cg.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> disait dernièrement que :

> This one on attempting to start firefox.
> Regards
> Sid.

about the 2 reports you made about oopses, try this
cd /path/to/your/kernel/source
wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/nroken-out/optimize-profile-path-slightly.patch
patch -R -p1 -i optimize-profile-path-slightly.patch

it should fix them

Regards,

-- 
nailed to the wall adj. 

 [like a trophy] Said of a bug
   finally eliminated after protracted, and even heroic, effort.

