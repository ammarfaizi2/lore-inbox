Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbTJUIMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 04:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbTJUIMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 04:12:12 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:51465 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262814AbTJUIMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 04:12:10 -0400
Date: Tue, 21 Oct 2003 09:12:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>,
       Mike Christie <mikenc@us.ibm.com>
Subject: Re: [patch] qlogic: force can_queue
Message-ID: <20031021091209.B22761@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Mike Christie <mikenc@us.ibm.com>
References: <20031020232732.GE473@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031020232732.GE473@cathedrallabs.org>; from aris@cathedrallabs.org on Mon, Oct 20, 2003 at 09:27:32PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 09:27:32PM -0200, Aristeu Sergio Rozanski Filho wrote:
> hi,
> 	should this be done or should i kill can_queue from all drivers and
> call BUG() if anyone tries to be loaded without being able to queue?

For 2.6 we'll keep a WARN_ON to catch old broken drivers.

