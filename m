Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132854AbRDPGPn>; Mon, 16 Apr 2001 02:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132855AbRDPGPe>; Mon, 16 Apr 2001 02:15:34 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:7430 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132854AbRDPGPX>;
	Mon, 16 Apr 2001 02:15:23 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104160615.f3G6FHf418941@saturn.cs.uml.edu>
Subject: Re: CML2 1.1.1, wiuth experimental fast mode
To: esr@snark.thyrsus.com (Eric S. Raymond)
Date: Mon, 16 Apr 2001 02:15:17 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104150345.f3F3jxG16241@snark.thyrsus.com> from "Eric S. Raymond" at Apr 14, 2001 11:45:59 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	* Added fast-mode command to suppress side-effect computation 
> 	  on slow machines.

You could put the computation in a low-priority thread, so that it
still gets done but doesn't mess up responsiveness.
