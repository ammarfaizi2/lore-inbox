Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266215AbUHBBx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUHBBx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 21:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUHBBx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 21:53:28 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:53718 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S266215AbUHBBx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 21:53:27 -0400
From: Daniel Phillips <phillips@istop.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Subject: Re: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Date: Sun, 1 Aug 2004 21:53:46 -0400
User-Agent: KMail/1.6.2
Cc: "Walker, Bruce J" <bruce.walker@hp.com>,
       Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       opengfs-devel@lists.sourceforge.net,
       opengfs-users@lists.sourceforge.net,
       opendlm-devel@lists.sourceforge.net
References: <3689AF909D816446BA505D21F1461AE4C750E6@cacexc04.americas.cpqcorp.net> <200408011330.01848.phillips@istop.com> <410D2949.20503@backtobasicsmgmt.com>
In-Reply-To: <410D2949.20503@backtobasicsmgmt.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408012153.46835.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 August 2004 13:32, Kevin P. Fleming wrote:
> Daniel Phillips wrote:
> > On Saturday 31 July 2004 12:00, Walker, Bruce J wrote:
> >>In the 2.4 implementation, providing this one capability by
> >>leveraging devfs was quite economic, efficient and has been very stable.
> >
> > I wonder if device-mapper (slightly hacked) wouldn't be a better approach
> > for 2.6+.
>
> It appeared from the original posting that their "cluster-wide devfs"
> actually supported all types of device nodes, not just block devices. I
> don't know whether accessing a character device on another node would
> ever be useful, but certainly using device-mapper wouldn't help for that
> case.

Unless device-mapper learned how to deal with char devices...

Just a thought.

Regards,

Daniel
