Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271713AbTHRMY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271714AbTHRMY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:24:57 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:1292 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271713AbTHRMYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:24:54 -0400
Date: Mon, 18 Aug 2003 13:24:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: Dominik.Strasser@t-online.de, hch@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030818132451.A22393@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, Dominik.Strasser@t-online.de,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <UTC200308181219.h7ICJfw14963.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200308181219.h7ICJfw14963.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Aug 18, 2003 at 02:19:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 02:19:41PM +0200, Andries.Brouwer@cwi.nl wrote:
> The right approach is not to break userspace without any kernel
> benefit whatsoever, but to eliminate the accumulated cruft from
> scsi.h.

Userspace is supposed to use the glibc <scsi/scsi.h> which is there
for exactly that reason.

