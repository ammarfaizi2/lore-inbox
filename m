Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265107AbSJWRiK>; Wed, 23 Oct 2002 13:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbSJWRiK>; Wed, 23 Oct 2002 13:38:10 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:25668 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265107AbSJWRiJ>; Wed, 23 Oct 2002 13:38:09 -0400
Date: Wed, 23 Oct 2002 10:52:35 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, <lkcd-devel@lists.sourceforge.net>
Subject: Re: [PATCH] LKCD for 2.5.44 (3/8): kerntypes addition
In-Reply-To: <20021023175938.A16547@infradead.org>
Message-ID: <Pine.LNX.4.44.0210231051250.28800-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Christoph Hellwig wrote:
|>On Wed, Oct 23, 2002 at 02:44:04AM -0700, Matt D. Robinson wrote:
|>> This adds kerntypes into the build so that symbols can be
|>> extracted from a single build object in the kernel.  This
|>> also modifies the install process (where applicable) to
|>> copy the Kerntypes file along with the kernel and map.
|>
|>Why can't you directly link in init/kerntypes.o?

We wanted to keep the bloat down, even as far as the
file size is concerned.  Some people have problems with
making the kernel image larger than it already is.  If
Kerntypes adds another 100K to the image, that isn't a
good thing in the eyes of some people.

--Matt

