Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSKVVUH>; Fri, 22 Nov 2002 16:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSKVVUH>; Fri, 22 Nov 2002 16:20:07 -0500
Received: from holomorphy.com ([66.224.33.161]:46727 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264745AbSKVVUG>;
	Fri, 22 Nov 2002 16:20:06 -0500
Date: Fri, 22 Nov 2002 13:24:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [BK-2.5] [PATCH] bootmem crash fix
Message-ID: <20021122212419.GY23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@digeo.com
References: <200211222005.gAMK5t319194@hera.kernel.org> <20021122.131259.66318468.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021122.131259.66318468.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2002 at 01:12:59PM -0800, David S. Miller wrote:
> __pa(PAGE_OFFSET) is not necessarily the first physical address in
> the system either.
> I've never seen this even implied to be the case :-)
> In any event, it isn't well defined and we should make it
> so.

Would a first_pfn variable be in order?


Bill
