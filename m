Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbRFKSSx>; Mon, 11 Jun 2001 14:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbRFKSSm>; Mon, 11 Jun 2001 14:18:42 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:52742 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262432AbRFKSSd>;
	Mon, 11 Jun 2001 14:18:33 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106111818.f5BIIUg133947@saturn.cs.uml.edu>
Subject: Re: IBM PPC 405 series little endian?
To: TZ@link.topcall.co.at (Zehetbauer Thomas)
Date: Mon, 11 Jun 2001 14:18:30 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <41EA756DBC9FD0118CFC0020AFDB5C5A188DE7@tcint1ntsrv> from "Zehetbauer Thomas" at Jun 11, 2001 01:34:21 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zehetbauer Thomas writes:

> Has someone experimented with running linux in little-endian mode on IBM
> PowerPC 405 (Walnut) yet?

I doubt it. You are at least the 3rd person to want little-endian.
Somebody at Matrox posted a patch for little-endian on the 74xx.
You need a bit more than that though; you need to change the way
page table bits get set and modify head_4xx.S IIRC.
