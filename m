Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTKZNJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTKZNJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:09:36 -0500
Received: from holomorphy.com ([199.26.172.102]:33981 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262705AbTKZNJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:09:35 -0500
Date: Wed, 26 Nov 2003 05:09:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Amir Hermelin <amir@montilio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PG_reserved bug
Message-ID: <20031126130927.GM8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Amir Hermelin <amir@montilio.com>, linux-kernel@vger.kernel.org
References: <20031126125020.GL8039@holomorphy.com> <004501c3b41e$38b3c570$1d01a8c0@CARTMAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004501c3b41e$38b3c570$1d01a8c0@CARTMAN>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 03:07:13PM +0200, Amir Hermelin wrote:
> Can't I just not use the reserved bit (therefore effectively use the
> refcount), and keep the minimal count at 1 or 2?  Will that have the same
> effect as setting the reserved bit?

You can do that, yes. There are certain disadvantages to doing so, e.g.
poor interactions with higher-order allocations.


-- wli
