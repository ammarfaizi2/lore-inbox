Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264221AbRFRPZ2>; Mon, 18 Jun 2001 11:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264218AbRFRPZS>; Mon, 18 Jun 2001 11:25:18 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:21152 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264215AbRFRPZI>; Mon, 18 Jun 2001 11:25:08 -0400
Date: Mon, 18 Jun 2001 11:24:43 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Pete Wyckoff <pw@osc.edu>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [docPATCH] mm.h documentation
In-Reply-To: <20010618093546.A9415@osc.edu>
Message-ID: <Pine.LNX.4.33.0106181123170.17350-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Pete Wyckoff wrote:

> Minor nit.
>
> The field offset was renamed to index some time ago, but I can't
> figure out if the usage changed.  Can you fix the comment and educate
> us?

Offset was used to indicate the offset in bytes of the page in the object
page cache.  Index is the index of the page, ie in pages, not bytes.

		-ben

