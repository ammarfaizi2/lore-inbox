Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270113AbUJTL1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270113AbUJTL1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270123AbUJTL0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:26:44 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:43393 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S270113AbUJTLTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:19:12 -0400
Date: Wed, 20 Oct 2004 13:19:10 +0200
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org,
       linux-alpha@vger.kernel.org
Subject: Re: 2.4.27, alpha arch, make bootimage and make bootpfile fails
Message-ID: <20041020111910.GB6569@gamma.logic.tuwien.ac.at>
References: <20041012173344.GA21846@gamma.logic.tuwien.ac.at> <20041013233247.A11663@jurassic.park.msu.ru> <20041014130035.GA4152@gamma.logic.tuwien.ac.at> <20041019195450.A5679@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041019195450.A5679@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 19 Okt 2004, Ivan Kokshaysky wrote:
> I was able to reproduce that on SX164 with both bootpfile and bootpzfile.
> As it turns out, the final kernel destination overlaps the initial stack
> region. Please test the appended patch.

Bingo. Thanks a lot. I tested bootpfile and this worked without any
problems. Very nice.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
TUMBY (n.)
The involuntary abdominal gurgling which fills the silence following
someone else's intimate personal revelation.
			--- Douglas Adams, The Meaning of Liff
