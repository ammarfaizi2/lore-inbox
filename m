Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTEEOpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbTEEOpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:45:19 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:15627 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262290AbTEEOpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:45:18 -0400
Date: Mon, 5 May 2003 15:57:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505155745.A25585@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tigran Aivazian <tigran@veritas.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Terje Eggestad <terje.eggestad@scali.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
References: <20030505113330.B8615@devserv.devel.redhat.com> <Pine.LNX.4.44.0305051650270.1045-100000@einstein31.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305051650270.1045-100000@einstein31.homenet>; from tigran@veritas.com on Mon, May 05, 2003 at 04:53:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 04:53:12PM +0100, Tigran Aivazian wrote:
> > ... or a LD_PRELOAD library......
> 
> which doesn't work with statically linked binaries, does it?

No.  But given the source to the application you can
easily override glibc's weak malloc symbol at link-time.

