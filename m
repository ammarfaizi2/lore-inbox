Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbRF0UWg>; Wed, 27 Jun 2001 16:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbRF0UWQ>; Wed, 27 Jun 2001 16:22:16 -0400
Received: from f14a-pat.swiftview.com ([208.151.247.147]:19146 "EHLO
	swiftview.com") by vger.kernel.org with ESMTP id <S265180AbRF0UWG>;
	Wed, 27 Jun 2001 16:22:06 -0400
Message-ID: <3B3A3FA3.B482B78B@swiftview.com>
Date: Wed, 27 Jun 2001 13:18:43 -0700
From: Scott Long <scott@swiftview.com>
Reply-To: scott@swiftview.com
Organization: SwiftView, Inc.
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: wake_up vs. wake_up_sync
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble understanding the difference between these.
Synchronous apparently causes try_to_wake_up() to NOT call
reschedule_idle() but I'm uncertain what reschedule_idle() is doing. I
assume it just looks for an idle CPU and makes that CPU reschedule.

What is the purpose of wake_up_sync? Why would you want to prevent
reschedule_idle()?

Scott
