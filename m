Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265353AbSJXI1V>; Thu, 24 Oct 2002 04:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265354AbSJXI1V>; Thu, 24 Oct 2002 04:27:21 -0400
Received: from dsl-213-023-020-124.arcor-ip.net ([213.23.20.124]:20626 "EHLO
	starship") by vger.kernel.org with ESMTP id <S265353AbSJXI1V>;
	Thu, 24 Oct 2002 04:27:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball compared forvarious  fs.
Date: Thu, 24 Oct 2002 10:34:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Steven Cole <elenstev@mesatop.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1035402133.13140.251.camel@spc9.esa.lanl.gov> <20021023160450.E3750@redhat.com> <3DB70207.FBB38A0D@digeo.com>
In-Reply-To: <3DB70207.FBB38A0D@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E184dRY-0007Mx-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 October 2002 22:09, Andrew Morton wrote:
> ext3's five-second commit interval and limited journal size really
> bite in this test.  We end up doing most of the writeback within
> the measurement period rather than after it.

The test results should include *both* the time the tar completes
and the time a subsequent sync completes, to tell the whole story.

-- 
Daniel
