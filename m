Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282118AbRLDGKq>; Tue, 4 Dec 2001 01:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282111AbRLDGKg>; Tue, 4 Dec 2001 01:10:36 -0500
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:56828 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S282109AbRLDGKS>; Tue, 4 Dec 2001 01:10:18 -0500
From: junio@siamese.dhis.twinsun.com
To: erik.tews@gmx.net (Erik Tews)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange messages with 2.4.16
In-Reply-To: <20011203233612.J11967@no-maam.dyndns.org>
Date: 03 Dec 2001 22:10:13 -0800
In-Reply-To: <20011203233612.J11967@no-maam.dyndns.org>
Message-ID: <7vlmgjcy7u.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Erik" == Erik Tews <erik.tews@gmx.net> writes:

Erik> invalidate: busy buffer

Erik> ... What do they want to
Erik> tell me? Has anybody else seen this messages?

I see them during shutdown (or reboot); a quick grep shows that
they are coming from fs/buffer.c: invalidate_bdev().  My kernel
is with RAID-1, and without lvm.

