Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTANKXA>; Tue, 14 Jan 2003 05:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTANKXA>; Tue, 14 Jan 2003 05:23:00 -0500
Received: from verein.lst.de ([212.34.181.86]:18693 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262190AbTANKW7>;
	Tue, 14 Jan 2003 05:22:59 -0500
Date: Tue, 14 Jan 2003 11:31:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Hugh Dickins <hugh@veritas.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
Message-ID: <20030114113135.A14279@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Tigran Aivazian <tigran@veritas.com>,
	Hugh Dickins <hugh@veritas.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301131851060.9994-100000@localhost.localdomain> <Pine.LNX.4.33.0301140932210.1110-100000@einstein31.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0301140932210.1110-100000@einstein31.homenet>; from tigran@veritas.com on Tue, Jan 14, 2003 at 09:34:52AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 09:34:52AM +0000, Tigran Aivazian wrote:
> Hi Christoph,
> 
> I don't know about mtrr (probably does it for the same reason) but the
> reason why microcode driver uses a regular file is because it needs
> something that only regular files can provide --- the file size.
> 
> This is an easy external "signifier" as to whether a successfull microcode
> update has occurred or not.

It seems to work without that feature on systems that don't have devfs..

