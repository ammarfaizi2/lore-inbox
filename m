Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317920AbSGWCTS>; Mon, 22 Jul 2002 22:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317921AbSGWCTS>; Mon, 22 Jul 2002 22:19:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60329 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317920AbSGWCTR>;
	Mon, 22 Jul 2002 22:19:17 -0400
Date: Mon, 22 Jul 2002 19:11:52 -0700 (PDT)
Message-Id: <20020722.191152.08962327.davem@redhat.com>
To: bcrl@redhat.com
Cc: dalecki@evision.ag, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.27 enum
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020722160118.G6428@redhat.com>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
	<3D3BE421.3040800@evision.ag>
	<20020722160118.G6428@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Mon, 22 Jul 2002 16:01:18 -0400
   
   Please don't apply this.  By leaving the trailing "," on enums, additional 
   values can be added by merely inserting an additional + line in a patch, 
   otherwise there are excess conflicts when multiple patches add values to 
   the enum.

I totally agree.

What is the purpose of all of these zany patches?  Are you going to
remove the inline assembler from the whole tree too? :-)
