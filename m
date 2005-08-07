Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752689AbVHGU1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbVHGU1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 16:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbVHGU1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 16:27:49 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:4153 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752689AbVHGU1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 16:27:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ajgMq9GAgcW4MnIq5I9S4+n4bFr9HXfjxLe1KBj4yNufu0VAzd606Ym9ublYOp2Bz71hapfNgDxhB1ijePa834KwDSFTHxVsyV+o20CzJRXjq4q/VK58jnyUDEH+YrC0q5icbyJB1KC3G4iBhxm54TM6fPE5bsRIAW8cbGReagY=
Message-ID: <42F66E81.2020807@gmail.com>
Date: Sun, 07 Aug 2005 16:26:41 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: synchronize_rcu vs. rcu_barrier
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the difference between synchronize_rcu() and rcu_barrier() (new function 
used only by reiser4 code)? From the scant documentation it seems like they do 
the same thing.

Keenan
