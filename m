Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269002AbRHGQvY>; Tue, 7 Aug 2001 12:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269001AbRHGQvO>; Tue, 7 Aug 2001 12:51:14 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:52842 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S269002AbRHGQvD>; Tue, 7 Aug 2001 12:51:03 -0400
Date: Tue, 7 Aug 2001 12:51:05 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.31.0108070920440.31117-100000@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108071245250.30280-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Linus Torvalds wrote:

> Try pre4.

It's similarly awful (what did you expect -- there are no meaningful
changes between the two!).  io throughput to a 12 disk array is humming
along at a whopping 40MB/s (can do 80) that's very spotty and jerky,
mostly being driven by syncs.  vmscan gets delayed occasionally, and small
interactive program loading varies from not to long (3s) to way too long
(> 30s).

		-ben

