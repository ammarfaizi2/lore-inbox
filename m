Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTANMlq>; Tue, 14 Jan 2003 07:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbTANMlq>; Tue, 14 Jan 2003 07:41:46 -0500
Received: from verein.lst.de ([212.34.181.86]:4102 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262425AbTANMlq>;
	Tue, 14 Jan 2003 07:41:46 -0500
Date: Tue, 14 Jan 2003 13:50:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Hugh Dickins <hugh@veritas.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
Message-ID: <20030114135033.A15280@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Tigran Aivazian <tigran@veritas.com>,
	Hugh Dickins <hugh@veritas.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030114113135.A14279@lst.de> <Pine.LNX.4.33.0301141145370.1241-100000@einstein31.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0301141145370.1241-100000@einstein31.homenet>; from tigran@veritas.com on Tue, Jan 14, 2003 at 11:48:58AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 11:48:58AM +0000, Tigran Aivazian wrote:
> a) if devfs is available it provides a regular file whose size can be
> examined by applications and content read/written without much "fuss". In
> particular it is very convenient to say "vi microcode" and examine the
> content directly. If it was a device node then this would have been
> impossible.

What do you think about adding a sysvfs attribute for that instead in
2.5?  This seems to be the much more logical interface to me..

