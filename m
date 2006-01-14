Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWANQVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWANQVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWANQVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:21:48 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:8593 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751776AbWANQVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:21:47 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2.6.15-mm4] sem2mutex: drivers/input/, #2
Date: Sat, 14 Jan 2006 11:21:42 -0500
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
References: <20060114160253.GA1073@elte.hu>
In-Reply-To: <20060114160253.GA1073@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141121.43749.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 11:02, Ingo Molnar wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> semaphore to mutex conversion.
> 
> the conversion was generated via scripts, and the result was validated
> automatically via a script as well.
>

All input related mutex conversions look fine so far. What are the plans
on merging it? Do you want to trickle them in through subsystems or just
submit as one batch? IOW do you want me to apply these patches?

-- 
Dmitry
