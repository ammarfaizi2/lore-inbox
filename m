Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289795AbSA2SeN>; Tue, 29 Jan 2002 13:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289796AbSA2SeD>; Tue, 29 Jan 2002 13:34:03 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:44188 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289795AbSA2Sdu>; Tue, 29 Jan 2002 13:33:50 -0500
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C5600A6.3080605@nyc.rr.com>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 29 Jan 2002 19:33:29 +0100
Message-ID: <87n0yxqa6e.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

John Weber <weber@nyc.rr.com> writes:

> I am currently writing code to scan the usual places for linux patches
> and automatically add them to our databases.  This would be really
> simplified by having patches sent to us.  And, since we already have a

How about extracting patches from lkml with procmail?

---cut here-->8---
:0 :
* ^sender: linux-kernel-owner@vger.kernel.org
* ^subject:.*patch
{
	:0 Bc:
	* ^--- .*/
	* ^+++ .*/
	linux-kernel-patches
}
---8<--cut here---

This recipe has its limits, but it's a start.

Regards, Olaf.
