Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318720AbSHERLM>; Mon, 5 Aug 2002 13:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318722AbSHERLM>; Mon, 5 Aug 2002 13:11:12 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:43268 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318720AbSHERLL>; Mon, 5 Aug 2002 13:11:11 -0400
Date: Mon, 5 Aug 2002 18:14:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arndb@de.ibm.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 14/18 support for partition labels in devfs
Message-ID: <20020805181445.C16035@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arndb@de.ibm.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <200208051830.50713.arndb@de.ibm.com> <200208051950.10785.arndb@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208051950.10785.arndb@de.ibm.com>; from arndb@de.ibm.com on Mon, Aug 05, 2002 at 07:50:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 07:50:10PM +0200, Arnd Bergmann wrote:
> This patch adds a new feature to the partition code. It will automatically
> generate links in the device filesystem from the label name of a dasd to
> the device node. This is only needed if the device filesystem is used.

Sorry, a s390-only /dev/labels/ is not acceptable.  There are more than
enough storage devices that can support labels.  And even a generic
implementation should go into 2.5 first.

