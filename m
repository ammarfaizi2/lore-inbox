Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270075AbRIAFOo>; Sat, 1 Sep 2001 01:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270132AbRIAFOZ>; Sat, 1 Sep 2001 01:14:25 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:1546 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S270075AbRIAFOR>;
	Sat, 1 Sep 2001 01:14:17 -0400
Date: Sat, 1 Sep 2001 00:50:30 -0400 (EDT)
From: Olivier Crete <Tester@videotron.ca>
X-X-Sender: <Tester@TesterTop.PolyDom>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
In-Reply-To: <Pine.LNX.4.33.0108311244070.2899-100000@TesterTop.PolyDom>
Message-ID: <Pine.LNX.4.33.0109010022440.1295-100000@TesterTop.PolyDom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ok, I've tried removing different parts of the kernel and I have been able
to find that the instability (repetable freezes) start to appear when the
yenta_socket.o module is loaded. I dont see the link between this module
and the events that trigger the freezes... It crashes when I do the
following things: use any of the non-keyboard buttons (thinkpad buttons
and volume control), brightness control, etc.. These buttons fn-X
combination have in common that they do not generate a scancode as shown
by showkey.

-- 
Olivier Crete
Tester
tester@videotron.ca
oliviercrete@videotron.ca

Those who do not understand Unix are condemned to reinvent it, poorly. -- Henry Spencer


