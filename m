Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283326AbRK2RIA>; Thu, 29 Nov 2001 12:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283329AbRK2RHu>; Thu, 29 Nov 2001 12:07:50 -0500
Received: from zero.tech9.net ([209.61.188.187]:61450 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S283326AbRK2RHj>;
	Thu, 29 Nov 2001 12:07:39 -0500
Subject: Re: interrupt ?
From: Robert Love <rml@tech9.net>
To: McEnroe <mcensamuel@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001601c17873$c664ee00$8b64a8c0@PREM>
In-Reply-To: <3C043B11.2FA17A19@pobox.com> <3C05B561.75F210C7@pobox.com> 
	<001601c17873$c664ee00$8b64a8c0@PREM>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 29 Nov 2001 12:07:37 -0500
Message-Id: <1007053658.813.17.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-28 at 20:18, McEnroe wrote:

> what is fast and slow interrupt ?
> what is the difference between this ?

fast interrupts occur with interrupts disabled, and are expected to be
completed quickly -- they are performed by the interrupt handlers
themselves.

a slow interrupt occurs with interrupts enabled, such as bottom half
tasks.

	Robert Love

