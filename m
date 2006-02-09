Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422758AbWBIQkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWBIQkC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422767AbWBIQkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:40:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422758AbWBIQkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:40:00 -0500
Date: Thu, 9 Feb 2006 11:38:45 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Nathan Lynch <ntl@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, ak@muc.de, 76306.1226@compuserve.com,
       wli@holomorphy.com, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
In-Reply-To: <20060209161331.GE20554@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.63.0602091138350.23817@cuia.boston.redhat.com>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
 <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
 <20060208190512.5ebcdfbe.akpm@osdl.org> <20060208190839.63c57a96.akpm@osdl.org>
 <43EAC6BE.2060807@cosmosbay.com> <20060208204502.12513ae5.akpm@osdl.org>
 <20060209160808.GL18730@localhost.localdomain> <20060209161331.GE20554@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2006, Heiko Carstens wrote:

> Simply because there is no such interface on s390. The only thing we know
> for sure is that if we are running under z/VM the user is free to
> configure up to 63 additional virtual cpus on the fly...

Xen is in a similar situation.

-- 
All Rights Reversed
