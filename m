Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317418AbSGZJTj>; Fri, 26 Jul 2002 05:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSGZJTj>; Fri, 26 Jul 2002 05:19:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26356 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317418AbSGZJTi>; Fri, 26 Jul 2002 05:19:38 -0400
Subject: Re: LVM 1.0.5 patch for Linux 2.4.19-rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Christoph Hellwig <hch@infradead.org>,
       "Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
       linux-kernel@vger.kernel.org, mge@sistina.com
In-Reply-To: <3D409C3C.8090009@evision.ag>
References: <20020725153944.A8060@sistina.com>
	<20020725155433.A12776@infradead.org>  <3D409C3C.8090009@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 11:36:37 +0100
Message-Id: <1027679797.13429.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 01:47, Marcin Dalecki wrote:
> Christoph applying the patch and rediffing with diffs "ingore white 
> space' options can help you here.
> And plese note that this kind of problems wouldn't be that common
> if we finally decided to make indent -kr -i8 mandatory.

indent -kr -i8 -bri0  (-l255 is also a good idea) doesn't produce the
same output for all whitespace/wrapped inputs. A long time ago I tried
to work that way and it caused much pain.


