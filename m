Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316765AbSE0VeW>; Mon, 27 May 2002 17:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSE0VeV>; Mon, 27 May 2002 17:34:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43013 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316765AbSE0VeT>; Mon, 27 May 2002 17:34:19 -0400
Message-ID: <3CF2A648.1070303@zytor.com>
Date: Mon, 27 May 2002 14:34:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <actahk$6bp$1@ID-44327.news.dfncis.de> <3CF23893.207@loewe-komp.de> <1022513156.1126.289.camel@irongate.swansea.linux.org.uk> <acu82e$7qn$1@cesium.transmeta.com> <20020527173306.C15560@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Mon, May 27, 2002 at 02:22:22PM -0700, H. Peter Anvin wrote:
> 
>>Well, if you can't fork a new process because that would push you into
>>overcommit, then you usually can't actually do anything useful on the
>>machine.
> 
> 
> Just use vfork or clone + exec.  It's faster and uses less memory.
> 

Doesn't help.  exec() should fail.

	-hpa


