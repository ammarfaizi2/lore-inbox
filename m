Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318257AbSIBKFn>; Mon, 2 Sep 2002 06:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318263AbSIBKFn>; Mon, 2 Sep 2002 06:05:43 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:15752 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318257AbSIBKFm>;
	Mon, 2 Sep 2002 06:05:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "David S. Miller" <davem@redhat.com>, wli@holomorphy.com
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Date: Mon, 2 Sep 2002 12:11:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: rml@tech9.net, rusty@rustcorp.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
References: <20020902003318.7CB682C092@lists.samba.org> <20020902060257.GO888@holomorphy.com> <20020901.232021.00308364.davem@redhat.com>
In-Reply-To: <20020901.232021.00308364.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17loBW-0004gM-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 08:20, David S. Miller wrote:
>    From: William Lee Irwin III <wli@holomorphy.com>
>    Date: Sun, 1 Sep 2002 23:02:57 -0700
>    
>    On Mon, Sep 02, 2002 at 01:51:54AM -0400, Robert Love wrote:
>    > I am all for your cleanup here, but two nits:
>    > Why not rename list_head while at it?  I would vote for just "struct
>    > list" ... the name is long, and I like my lines to fit 80 columns.
>    
>    Seconded. Throw the whole frog in the blender, please, not just half.
> 
> The problem is, it isn't a "list", it's a "list header" or "list
> marker", ie. a list_head.

No it's not, it's nothing more nor less than a list node, identically,
a list.

-- 
Daniel
