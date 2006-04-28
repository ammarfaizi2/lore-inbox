Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWD1PdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWD1PdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWD1PdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:33:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:13218 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030433AbWD1PdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:33:07 -0400
Date: Fri, 28 Apr 2006 17:32:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Adrian Bunk <bunk@stusta.de>, David Woodhouse <dwmw2@infradead.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
In-Reply-To: <Pine.LNX.4.64.0604271656390.3701@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0604281729250.9011@yvahk01.tjqt.qr>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org> <1146105458.2885.37.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org> <1146107871.2885.60.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org> <20060427213754.GU3570@stusta.de>
 <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org> <20060427231200.GW3570@stusta.de>
 <Pine.LNX.4.64.0604271656390.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Last I heard, a lot of people wanted to avoid that duplication, and 
>actually wanted the kabi headers exactly because they wanted just _one_ 
>place for these things.
>
Sounds like they want it BSD-style. Do they realize that?
New release, new headers, making it necessary to recompile every app, 
because a struct could have changed. That'd seriously impact 
compatibility.


Jan Engelhardt
-- 
