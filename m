Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbTJOM4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTJOM4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:56:03 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:31245 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263083AbTJOM4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:56:01 -0400
Date: Wed, 15 Oct 2003 13:55:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com, jbarnes@sgi.com
Subject: Re: [PATCH] Altix I/O code cleanup
Message-ID: <20031015135558.A8963@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@trained-monkey.org>, Patrick Gefre <pfg@sgi.com>,
	linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com,
	jbarnes@sgi.com
References: <3F872984.7877D382@sgi.com> <20031013095652.A25495@infradead.org> <yq0llrmncus.fsf@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <yq0llrmncus.fsf@trained-monkey.org>; from jes@trained-monkey.org on Wed, Oct 15, 2003 at 04:07:07AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 04:07:07AM -0400, Jes Sorensen wrote:
> Christoph> NULL return not handled again (and the assert is totally
> Christoph> useless)
> 
> ASSERT_ALWAYS checks it, it may not be pretty but it does check it.

No, it's useless.  It's not different at all from just derefencing a
NULL pointer - both get you an oops.

