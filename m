Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265366AbRF0SnF>; Wed, 27 Jun 2001 14:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265364AbRF0Smz>; Wed, 27 Jun 2001 14:42:55 -0400
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:51333 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S265366AbRF0Smo>;
	Wed, 27 Jun 2001 14:42:44 -0400
Date: Wed, 27 Jun 2001 14:42:39 -0400
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc ." <linux-kernel@vger.kernel.org>
Subject: Allocating non-contigious memory
Message-ID: <20010627144239.A2265@zalem.puupuu.org>
Mail-Followup-To: "Hack inc ." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the Right Way[tm] as of 2.4.6 to allocate 16Mb as 4K pages and
get the pci bus address for each page?  Bonus points is they're
virtually contiguous, but that's not necessary.  IIRC, the old
vmalloc-then-walk-the-pagetables trick is considered out-of-bounds
nowadays.

  OG.

