Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSG3Iik>; Tue, 30 Jul 2002 04:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSG3Iik>; Tue, 30 Jul 2002 04:38:40 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:47629 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315265AbSG3Iij>; Tue, 30 Jul 2002 04:38:39 -0400
Date: Tue, 30 Jul 2002 09:42:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc3aa4
Message-ID: <20020730094202.A7438@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20020730060218.GB1181@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020730060218.GB1181@dualathlon.random>; from andrea@suse.de on Tue, Jul 30, 2002 at 08:02:18AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only in 2.4.19rc3aa4: 9900_aio-1.gz
> 
> 	Merged async-io from Benjamin LaHaise after purifying it from the
> 	/proc/libredhat.so mess that made it not binary compatible with 2.5.

As there is no finished aio ABI for 2.5 it can't be binary compatible.  But
unlike your version Ben's patch is not very likely to conflict with new
2.5 features soon.  An no, there is no such thing as /proc/libredhat.so in
his patch.
