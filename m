Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316764AbSE0VdG>; Mon, 27 May 2002 17:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316765AbSE0VdF>; Mon, 27 May 2002 17:33:05 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:20986 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316764AbSE0VdF>; Mon, 27 May 2002 17:33:05 -0400
Date: Mon, 27 May 2002 17:33:06 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
Message-ID: <20020527173306.C15560@redhat.com>
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <actahk$6bp$1@ID-44327.news.dfncis.de> <3CF23893.207@loewe-komp.de> <1022513156.1126.289.camel@irongate.swansea.linux.org.uk> <acu82e$7qn$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 02:22:22PM -0700, H. Peter Anvin wrote:
> Well, if you can't fork a new process because that would push you into
> overcommit, then you usually can't actually do anything useful on the
> machine.

Just use vfork or clone + exec.  It's faster and uses less memory.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
