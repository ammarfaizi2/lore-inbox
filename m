Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTLHVYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 16:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTLHVYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 16:24:09 -0500
Received: from 66.80-203-43.nextgentel.com ([80.203.43.66]:18898 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261719AbTLHVYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 16:24:08 -0500
Subject: Re: 2.4: mylex and > 2GB RAM
From: Per Andreas Buer <perbu@linpro.no>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031208210201.GP8039@holomorphy.com>
References: <1070897058.25490.56.camel@netstat.linpro.no>
	 <20031208153641.GJ8039@holomorphy.com>
	 <1070898870.25490.76.camel@netstat.linpro.no>
	 <20031208162214.GW19856@holomorphy.com>
	 <PERBUMSGID-ul6d6azt6b0.fsf@nfsd.linpro.no>
	 <20031208202229.GO8039@holomorphy.com>
	 <1070917304.1260.44.camel@localhost.localdomain>
	 <20031208210201.GP8039@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Linpro AS
Message-Id: <1070918737.1260.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 08 Dec 2003 22:25:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-08 at 22:02, William Lee Irwin III wrote:
> Actually, this suggests lowmem starvation due to bounce buffering.

The kernel is compiled with CONFIG_HIGHIO=y. Do you know if this is a
DAC960 issue or a chipset issue?

-- 
Per Andreas Buer <perbu@linpro.no>
