Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265882AbTGDIi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbTGDIi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:38:27 -0400
Received: from holomorphy.com ([66.224.33.161]:38092 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265882AbTGDIiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:38:23 -0400
Date: Fri, 4 Jul 2003 01:52:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, helgehaf@aitel.hist.no,
       zboszor@freemail.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030704085208.GX26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>, helgehaf@aitel.hist.no,
	zboszor@freemail.hu, linux-kernel@vger.kernel.org
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu> <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no> <20030703141508.796e4b82.akpm@osdl.org> <20030704055315.GW26348@holomorphy.com> <Pine.LNX.4.53.0307040307090.24383@montezuma.mastecende.com> <20030704012734.77f99e74.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704012734.77f99e74.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 01:27:34AM -0700, Andrew Morton wrote:
> fixes it up, and looks nicer anyway.  Removing the volatiles (what were
> they doing there?) did not fix it.  The `nr' thing fixed it.  

Those were to prevent warnings in case someone passed in a volatile
bitmap. Which no one is doing at the moment that I know of offhand.


-- wli
