Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSIEFfx>; Thu, 5 Sep 2002 01:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSIEFfx>; Thu, 5 Sep 2002 01:35:53 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:3845 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316878AbSIEFfw>; Thu, 5 Sep 2002 01:35:52 -0400
Date: Thu, 5 Sep 2002 07:40:08 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Chris Mason <mason@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, "David S. Miller" <davem@redhat.com>,
       shaggy@austin.ibm.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com, green@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020905054008.GH24323@louise.pinerecords.com>
References: <200209042018.g84KI6612079@shaggy.austin.ibm.com> <3D766DA8.9030207@namesys.com> <20020904.163515.82835380.davem@redhat.com> <3D76A6FF.509@namesys.com> <1031186951.1684.205.camel@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031186951.1684.205.camel@tiny>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 10 days, 7:39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Our disk format has link counts > 32k

Does the internal reiserfs nlink value translate directly
to what stat() puts in st_nlink?
