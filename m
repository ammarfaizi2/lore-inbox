Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265915AbTGDIoT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265917AbTGDIoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:44:18 -0400
Received: from holomorphy.com ([66.224.33.161]:55244 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265915AbTGDIne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:43:34 -0400
Date: Fri, 4 Jul 2003 01:57:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, helgehaf@aitel.hist.no,
       zboszor@freemail.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030704085729.GZ26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>, helgehaf@aitel.hist.no,
	zboszor@freemail.hu, linux-kernel@vger.kernel.org
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu> <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no> <20030703141508.796e4b82.akpm@osdl.org> <20030704055315.GW26348@holomorphy.com> <Pine.LNX.4.53.0307040307090.24383@montezuma.mastecende.com> <20030704012734.77f99e74.akpm@osdl.org> <Pine.LNX.4.53.0307040437100.24383@montezuma.mastecende.com> <20030704015642.7840cab5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704015642.7840cab5.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 01:56:42AM -0700, Andrew Morton wrote:
> Like this.  I erased every `volatile' I could find.  No idea why they were
> in there.

Some were inherited from the preexisting code. The bitmap.h bits
were to prevent warnings when passed volatiles.


-- wli
