Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSIEGiD>; Thu, 5 Sep 2002 02:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSIEGiC>; Thu, 5 Sep 2002 02:38:02 -0400
Received: from bof.de ([195.4.223.10]:37524 "HELO oknodo.bof.de")
	by vger.kernel.org with SMTP id <S317091AbSIEGiC>;
	Thu, 5 Sep 2002 02:38:02 -0400
Date: Thu, 5 Sep 2002 08:39:32 +0200
From: Patrick Schaaf <bof@bof.de>
To: "David S. Miller" <davem@redhat.com>
Cc: bof@bof.de, rusty@rustcorp.com.au, ak@suse.de, laforge@gnumonks.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack_hash() problem
Message-ID: <20020905083932.F19551@oknodo.bof.de>
References: <20020905082128.D19551@oknodo.bof.de> <20020904.232425.10994370.davem@redhat.com> <20020905083340.E19551@oknodo.bof.de> <20020904.233226.108195359.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020904.233226.108195359.davem@redhat.com>; from davem@redhat.com on Wed, Sep 04, 2002 at 11:32:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 11:32:26PM -0700, David S. Miller wrote:
>    
>    So, I don't see how your (abstractly true) observation is relevant, here.
>    
> So we waste 4 bytes in the kernel for really no reason?
> A value we can compute in half a cycle?

Sorry, but I was under the impression that code readability was worth
the occasional static-global additional 4 bytes. I must have been
mistaken.

best regards
  Patrick
