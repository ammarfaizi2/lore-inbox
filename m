Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266767AbSLPO3w>; Mon, 16 Dec 2002 09:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbSLPO3w>; Mon, 16 Dec 2002 09:29:52 -0500
Received: from fep02.superonline.com ([212.252.122.41]:36340 "EHLO
	fep02.superonline.com") by vger.kernel.org with ESMTP
	id <S266746AbSLPO3v>; Mon, 16 Dec 2002 09:29:51 -0500
From: "O.Sezer" <sezero@superonline.com>
To: linux-kernel@vger.kernel.org
Subject: Re: rmap and nvidia?
Date: Mon, 16 Dec 2002 16:25:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: 7bit
Message-Id: <20021216143446.KJIB19496.fep02@[212.252.122.46]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5 patches at http://www.minion.de/nvidia.html
may give some clue. They use pte_offset_map , yes,
but no corresponding pte_unmap ...

