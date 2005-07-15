Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263136AbVGOAzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbVGOAzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbVGOAzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 20:55:39 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:52039 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263136AbVGOAzg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 20:55:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fGyAO4kxXyw/wAsa4oY7MRzX4++cC3PoYOK3vGNHkcCcSO69n25tPPTwtSPKiHojXSk/i4OwNRtd3Q7Qig+ahS4NRiZfAYxqjNEhdegcw2Fz1dFJEeK5FzUERNpik+VBJIwBSSic+KHbSu0zLEac1/0TmttbTwntIJGQCdQ2VKg=
Message-ID: <28183df50507141755557b5145@mail.gmail.com>
Date: Fri, 15 Jul 2005 03:55:32 +0300
From: Zvi Rackover <zvirack@gmail.com>
Reply-To: Zvi Rackover <zvirack@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: interrupt hooking in kernel 2.6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all,

i wish to write a module for i386 that can hook interrupts. the module
loads its own interrupt descriptor table instead of the default
system's table. after executing my own handler(s), the old appropriate
handler will be called.
i could not find any documentation or sample code explaining how this
is done in 2.6. There are very few outdated examples on the web which
apparently are not suitable.
can anyone help me out?

yours,
zvi
