Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317910AbSGWCOa>; Mon, 22 Jul 2002 22:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317911AbSGWCOa>; Mon, 22 Jul 2002 22:14:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55209 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317910AbSGWCOa>;
	Mon, 22 Jul 2002 22:14:30 -0400
Date: Mon, 22 Jul 2002 19:07:11 -0700 (PDT)
Message-Id: <20020722.190711.09553251.davem@redhat.com>
To: vandrove@vc.cvut.cz
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] cli/sti in net/802/*
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020722194814.GA1668@vana.vc.cvut.cz>
References: <20020722194814.GA1668@vana.vc.cvut.cz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches don't make any sense.

You aren't blocking against other things that cli/sti used
to disable, namely timers and the generic input packet processing
engine.

There is no way these changes are a correct replacement for cli/sti.
This goes for your IPX changes too which I ask that you had pass
through Arnaldo de Melo in the future as he has done a lot of work
in this area.

